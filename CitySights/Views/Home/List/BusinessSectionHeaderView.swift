//
//  SectionHeaderView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/26/21.
//

import SwiftUI

struct BusinessSectionHeaderView: View {
    var title: String
    
    var body: some View {
        ZStack (alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
            
            Text(title)
                .font(.headline)
        }
    }
}
