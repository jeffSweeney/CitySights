//
//  HomeView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    // By default we'll show the list view - can toggle to map and state
    // property will update the view
    @State var isListShowing = true
    
    var body: some View {
        if model.restaurants.count == 0 && model.sights.count == 0 {
            // Could take a moment for data to arrive
            ProgressView()
        } else {
            if isListShowing {
                NavigationView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "mappin")
                            Text("Odenton, MD") // TODO: Update to not be hardcoded
                            Spacer()
                            Text("Map View")
                        }
                        .padding([.horizontal], 5)
                        
                        Divider()
                        
                        BusinessListView()
                    }
                    .padding([.horizontal, .top])
                    .tint(.black)
                    .navigationBarHidden(true)
                }
            } else {
                // TODO: Build the map view that can be toggled to
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
