//
//  Constants.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import Foundation

class Constants {
    // TODO: There's probably a more standardized way to accomplish this
    private init() {
        
    }
    
    // MARK: - Yelp API URL
    static let YelpApiUrl = "https://api.yelp.com/v3/businesses/search"
    
    // MARK: - Sights Categories
    static let Restaurants = "restaurants"
    static let ArtsAndEntertainment = "arts"
    
    // MARK: - Yelp API Query Parameters
    static let Latitude = "latitude"
    static let Longitude = "longitude"
    static let Categories = "categories"
    static let Limit = "limit"
    static let DefaultLimit = "6"
    
    // MARK: - HTTP Method and Authorization
    static let HTTPMethod = "GET"
    static let HTTPAuthorization = "Bearer \(PrivateConstants.APIKey)"
}
