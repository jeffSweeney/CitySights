//
//  BusinessTitleView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/9/22.
//

import SwiftUI

struct BusinessTitleView: View {
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading) {
            // Fixed size prevents long business names from abbreviating
            Text(business.name ?? "Name Unavailable")
                .bold()
                .font(.title2)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
            
            if let displayAddress = business.location?.displayAddress {
                ForEach(displayAddress, id: \.self) { line in
                    Text(line)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
            }
            
            if let rating = business.rating {
                Image("regular_\(rating)")
                    .padding(.horizontal)
            }
        }
    }
}
