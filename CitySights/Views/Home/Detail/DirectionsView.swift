//
//  DirectionsView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/9/22.
//

import SwiftUI

struct DirectionsView: View {
    
    @EnvironmentObject var contentModel: ContentModel
    
    var business: Business
    
    var body: some View {
        
        VStack (alignment: .leading) {
            // Business Title
            HStack {
                BusinessTitleView(business: business)
                
                Spacer()
                
                if let url = contentModel.getMapLink(business: business) {
                    Link("Open in Maps", destination: url)
                        .padding(.trailing, 10)
                } else {
                    Text("Directions Unavailable")
                        .bold()
                        .foregroundColor(.red)
                        .padding(.trailing, 10)
                }
            }
            
            // Directions Map
            DirectionsMap(business: business)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
