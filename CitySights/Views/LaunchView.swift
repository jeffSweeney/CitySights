//
//  LaunchView.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 12/23/21.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        // Detect authorization status of geo locating user
        // - if undetermined: show onboarding
        // - if approved: show home view
        // - if denied: show error and prompt for permission
        let authState = model.authorizationState
        if authState == .notDetermined {
            OnboardingView()
        }
        else if authState == .authorizedWhenInUse || authState == .authorizedAlways {
            HomeView()
        }
        else if authState == .denied {
            DeniedView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
