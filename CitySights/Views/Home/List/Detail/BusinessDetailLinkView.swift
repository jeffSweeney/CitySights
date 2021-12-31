//
//  BusinessDetailLinkView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/30/21.
//

import SwiftUI

struct BusinessDetailLinkView: View {
    var heading: String
    var headingValue: String
    var urlString: String
    var linkString: String
    
    var body: some View {
        HStack {
            Text("\(heading):")
                .bold()
            
            // When this is website it's using the LONG Yelp URL. Line
            // limit is a great workaround to abbriviate
            Text(headingValue)
                .lineLimit(1)
            
            Spacer()
            
            if let url = URL(string: urlString) {
                Link(destination: url) {
                    Text(linkString)
                }
            }
        }
        .padding()
    }
}
