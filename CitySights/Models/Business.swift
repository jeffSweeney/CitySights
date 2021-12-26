//
//  Business.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import Foundation

struct Business: Decodable {
    var id: String?
    var is_closed: Bool?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var image_url: String?
    var url: String?
    var phone: String?
    var display_phone: String?
    var price: String?
    var location: Location?
    var alias: String?
    var coordinates: Coordinate?
    var transactions: [String]?
    var distance: Double?
    var name: String?
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Location: Decodable {
    var display_address: [String]?
    var city: String?
    var address1: String?
    var address2: String?
    var address3: String?
    var zip_code: String?
    var country: String?
    var state: String?
}
