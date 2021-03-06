//
//  ContentModel.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/23/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var placemark: CLPlacemark?
    
    override init() {
        super.init()
        
        // Assign location manager delegate to self for handling permission selections
        locationManager.delegate = self
    }
    
    func requestGeoLocation() {
        // Request permission from the user to geo locate
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Published authorization state must reflect update
        DispatchQueue.main.async {
            self.authorizationState = self.locationManager.authorizationStatus
        }
        
        let authStatus = locationManager.authorizationStatus
        
        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else if authStatus == .denied {
            // We don't have permission - this is enforced to retry in the onboarding.
            // Keeping else if branch for this documentation.
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Capture locations and send off the the Yelp API
        if let userLocation = locations.first {
            // Only need location once - stop requesting
            locationManager.stopUpdatingLocation()
            
            // Retrieve and set the placemark of the user
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
                if error == nil && placemarks != nil {
                    self.placemark = placemarks!.first
                }
            }
            
            // Retrieve restaurants
            getBusinesses(Constants.Restaurants, userLocation)
            
            // Retrieve arts
            getBusinesses(Constants.ArtsAndEntertainment, userLocation)
            
        }
    }
    
    // MARK: - Yelp API Methods
    func getBusinesses(_ category: String, _ userLocation: CLLocation) {
        // Create URL
        var urlComponents = URLComponents(string: Constants.YelpApiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: Constants.Latitude, value: String(userLocation.coordinate.latitude)),
            URLQueryItem(name: Constants.Longitude, value: String(userLocation.coordinate.longitude)),
            URLQueryItem(name: Constants.Categories, value: category),
            URLQueryItem(name: Constants.Limit, value: Constants.DefaultLimit)
        ]
        
        if let url = urlComponents?.url {
            // Create URL Request
            var request =  URLRequest(
                url: url,
                cachePolicy: .reloadIgnoringLocalCacheData,
                timeoutInterval: 10.0
            )
            
            // Set HTTP Header
            request.httpMethod = Constants.HTTPMethod
            request.addValue(Constants.HTTPAuthorization, forHTTPHeaderField: "Authorization")
            
            // Get URL Session
            let session = URLSession.shared
            
            // Create Data Task
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    do {
                        let businessSearch = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Sort businesses by distance
                        var businesses = businessSearch.businesses
                        businesses.sort { b1, b2 in
                            (b1.distance ?? 0) < (b2.distance ?? 0)
                        }
                        
                        // Writing to published view code - MUST do so on main thread!
                        DispatchQueue.main.async {
                            // Retrieve the image data before assigning
                            for business in businesses {
                                business.getImageData()
                            }
                            
                            switch category {
                                case Constants.ArtsAndEntertainment:
                                    self.sights = businesses
                                case Constants.Restaurants:
                                    self.restaurants = businesses
                                default:
                                    print("UNSUPPORTED CATEGORTY")
                            }
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    print(error!)
                }
            }
            
            // Launch Data Task
            task.resume()
        }
    }
    
    // MARK: - Apple MapLinks
    func getMapLink(business: Business) -> URL? {
        var url: URL?
        
        // Declared as constant to shorten the optional binding line. Cleaner this way.
        let lat = business.coordinates?.latitude
        let long = business.coordinates?.longitude
        let name = business.name
        
        if let lat = lat, let long = long, let name = name {
            let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Location"
            url = URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(encodedName)")
        }
        
        return url
    }
}
