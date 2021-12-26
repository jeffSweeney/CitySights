//
//  BusinessSearch.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
