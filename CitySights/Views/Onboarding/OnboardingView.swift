//
//  OnboardingView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/13/22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var contentModel: ContentModel
    @State private var currentTab = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turq = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    private var color: Color {
        currentTab == 0 ? blue : turq
    }
    
    var body: some View {
        VStack {
            // TabView
            TabView(selection: $currentTab) {
                // First tab
                IntroView(
                    tag: 0,
                    title: "Welcome to City Sights!",
                    caption: "City Sights helps you find the best of the city!"
                )
                
                // Second tab
                IntroView(
                    tag: 1,
                    title: "Ready to discover your city?",
                    caption: "We'll show you the best restaurants, venues and more, based on your location!"
                )
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            // Button
            Button {
                if currentTab == 0 {
                    currentTab = 1
                } else {
                    contentModel.requestGeoLocation()
                }
            } label: {
                ZStack {
                    let text = (currentTab == 0) ? "Next" : "Get My Location"
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(text)
                        .bold()
                        .foregroundColor(color)
                        .padding()
                }
            }
            .accentColor(color)
            .padding(.horizontal, 10)
        }
        .background(color)
        .foregroundColor(.white)
    }
}
