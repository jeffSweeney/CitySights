//
//  IntroView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/13/22.
//

import SwiftUI

struct IntroView: View {
    
    var tag: Int
    var title: String
    var caption: String
    
    var body: some View {
        VStack (spacing: 20) {
            Image("City_Tab\(tag)")
                .resizable()
                .scaledToFit()
            
            Text(title)
                .bold()
                .font(.title)
            
            Text(caption)
        }
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .tag(tag)
    }
}
