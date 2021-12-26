//
//  BusinessListView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import SwiftUI

struct BusinessListView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            // App limits to 6 sights and 6 restaurants so Lazy is probably
            // overkill here - but it allows the app to extend it's capabilities
            // later on.
            LazyVStack (alignment: .leading, pinnedViews: [.sectionHeaders]) {
                // List view for restaurants
                BusinessSectionView(businesses: model.restaurants, sectionName: "Restaurants")
                // List view for sights
                BusinessSectionView(businesses: model.sights, sectionName: "Sights")
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
