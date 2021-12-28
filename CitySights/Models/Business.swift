//
//  Business.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import Foundation

class Business: Decodable, Identifiable, ObservableObject {
    @Published var imageData: Data?
    
    var id: String?
    var isClosed: Bool?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var imageUrl: String?
    var url: String?
    var phone: String?
    var displayPhone: String?
    var price: String?
    var location: Location?
    var alias: String?
    var coordinates: Coordinate?
    var transactions: [String]?
    var distance: Double?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        // Mapped key changes
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case imageUrl = "image_url"
        case displayPhone = "display_phone"
        
        // Remainder of non-changed keys
        case id
        case categories
        case rating
        case url
        case phone
        case price
        case location
        case alias
        case coordinates
        case transactions
        case distance
        case name
    }
    
    func distanceAsMiles() -> String {
        if let distance = distance {
            let miles = distance/Constants.MetersPerMile
            return String(format: "%.2f", miles)
        } else {
            return "Distance Unavailable"
        }
    }
    
    func getImageData() {
        if let imageUrl = imageUrl {
            if let url = URL(string: imageUrl) {
                let session = URLSession.shared
                
                session.dataTask(with: url) { (data, response, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.imageData = data!
                    }
                }.resume()
            }
        }
    }
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Location: Decodable {
    var displayAddress: [String]?
    var city: String?
    var address1: String?
    var address2: String?
    var address3: String?
    var zipCode: String?
    var country: String?
    var state: String?
    
    enum CodingKeys: String, CodingKey {
        // Mapped key changes
        case displayAddress = "display_address"
        case zipCode = "zip_code"
        
        // Remainder of non-changed keys
        case city
        case address1
        case address2
        case address3
        case country
        case state
    }
}
