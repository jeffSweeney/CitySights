//
//  DeniedView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/13/22.
//

import SwiftUI

struct DeniedView: View {
    private let colorTheme = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Whoops!")
                .bold()
                .foregroundColor(.white)
                .font(.title)
            
            Text("Accessing your location is a key component of the City Sights app. If you wish to use the app, please update your permissions in Settings.")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button(action: {
                // Open settings for change
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Open Settings")
                        .bold()
                        .padding()
                }
            }
            .accentColor(colorTheme)
            .padding(.horizontal, 10)
            
            Spacer()
        }
        .background(colorTheme)
    }
}

struct DeniedView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedView()
    }
}
