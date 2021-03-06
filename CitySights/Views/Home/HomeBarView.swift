//
//  HomeBarView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/8/22.
//

import SwiftUI

struct HomeBarView: View {
    @EnvironmentObject var contentModel: ContentModel
    
    @Binding var isListShowing: Bool
    var sfSymbol: String
    var switchToView: String
    
    var body: some View {
        HStack {
            Image(systemName: sfSymbol)
            
            Text(contentModel.placemark?.locality ?? "")
            
            Spacer()
            
            Button(action: {isListShowing.toggle()}) {
                Text("Switch to \(switchToView) View")
                    // Blue by default but the list view overrides nested text black. Keep
                    // this text blue!
                    .tint(.blue)
            }
        }
        .padding([.horizontal], 5)
    }
}
