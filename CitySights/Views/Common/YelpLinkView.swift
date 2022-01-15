//
//  YelpLinkView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/15/22.
//

import SwiftUI

struct YelpLinkView: View {
    var link: String
    
    var body: some View {
        let img = Image("yelp")
            .resizable()
            .scaledToFit()
            .frame(height: 36)
        
        if let url = URL(string: link) {
            Link(destination: url) { img }
        } else {
            img
        }
    }
}
