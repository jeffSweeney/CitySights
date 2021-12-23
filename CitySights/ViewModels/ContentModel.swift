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
    
    override init() {
        super.init()
        
        // Assign location manager delegate to self for handling permission selections
        locationManager.delegate = self
        
        // Request permission from the user to geo locate
        locationManager.requestWhenInUseAuthorization()

    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authStatus = locationManager.authorizationStatus
        
        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else if authStatus == .denied {
            // TODO: User MUST authorize permission for app to work - enforce
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Capture locations
        // TODO: Send location coordintes off to the Yelp API
        
        // Only need location once - stop requesting
        locationManager.stopUpdatingLocation()
    }
}
