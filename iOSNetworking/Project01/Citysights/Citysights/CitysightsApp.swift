//
//  CitysightsApp.swift
//  Citysights
//
//  Created by Bern N on 10/19/23.
//

import SwiftUI

@main
struct CitysightsApp: App {
    @State private var model = BusinessViewModel()
    @AppStorage("onboarding") private var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environment(model)
                }
                .onAppear {
                    // If no onboarding is needed, still get the user's location for up-to-date data on subsequent app launches.
                    if needsOnboarding == false && model.locationAuthStatus == .notDetermined {
                        model.getUserLocation()
                    }
                }
        }
    }
}
