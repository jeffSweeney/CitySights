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
    
    // Defined in sheet from BusinessMapView - set on annotation tap
    @State var selectedBusiness: Business?
    
    var body: some View {
        if model.restaurants.count == 0 && model.sights.count == 0 {
            // Could take a moment for data to arrive
            ProgressView()
        } else {
            if isListShowing {
                NavigationView {
                    VStack(alignment: .leading) {
                        HomeBarView(isListShowing: $isListShowing, sfSymbol: "mappin", switchToView: "Map")
                        
                        Divider()
                        
                        BusinessListView()
                    }
                    .padding([.horizontal, .top])
                    .tint(.black)
                    .navigationBarHidden(true)
                }
            } else {
                ZStack (alignment: .top) {
                    BusinessMapView(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            BusinessDetailView(business: business)
                        }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .frame(height: 48)
                        
                        HomeBarView(isListShowing: $isListShowing, sfSymbol: "location", switchToView: "List")
                    }
                    .padding()
                }
            }
        }
    }
}
