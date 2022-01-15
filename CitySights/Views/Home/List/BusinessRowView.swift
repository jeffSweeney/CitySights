//
//  BusinessRowView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/28/21.
//

import SwiftUI

struct BusinessRowView: View {
    // MUST be observed since the business row may have to wait a moment
    // for the image to be retrieved.
    @ObservedObject var business: Business
    
    var body: some View {
        VStack {
            HStack {
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(15.0)
                    .scaledToFit()
                
                VStack (alignment: .leading) {
                    // The NavigationView in HomeView makes multi-line text centered. Override
                    // this back to leading.
                    Text(business.name ?? "Name Unavailable")
                        .multilineTextAlignment(.leading)
                    Text("\(business.distanceAsMiles()) mi. away")
                        .font(.caption)
                }
                
                Spacer()
                
                VStack (alignment: .leading) {
                    Image("regular_\(business.rating ?? 0.0)")
                    
                    Text("\(business.reviewCount ?? 0) reviews")
                        .font(.caption)
                }
            }
            
            DashedDividerView()
                .padding(.vertical, 5)
        }
    }
}
