//
//  BusinessSectionView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import SwiftUI

struct BusinessSectionView: View {
    var businesses: [Business]
    var sectionName: String
    
    var body: some View {
        Section (header: BusinessSectionHeaderView(title: sectionName)) {
            // List all restaurants that have been retrieved
            ForEach(businesses) { business in
                BusinessRowView(business: business)
            }
        }
    }
}
