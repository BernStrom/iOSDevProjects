//
//  OnboardingView.swift
//  Citysights
//
//  Created by Bern N on 10/30/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(BusinessModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var selectedViewIndex = 0
    
    var body: some View {
        ZStack {
            if selectedViewIndex == 0 {
                Color(red: 111/255, green: 154/255, blue: 189/255)
            } else {
                Color(red: 139/255, green: 166/255, blue: 65/255)
            }
            
            TabView(selection: $selectedViewIndex) {
                OnboardingViewDetails(bgColor: Color(red: 111/255, green: 154/255, blue: 189/255), headline: "Welcome to Citysights", subHeadline: "Citysights helps you find the best of the city!") {
                    withAnimation {
                        selectedViewIndex = 1
                    }
                }
                .tag(0)
                .ignoresSafeArea()
                
                OnboardingViewDetails(bgColor: Color(red: 139/255, green: 166/255, blue: 65/255), headline: "Discover Your City", subHeadline: "We'll show you the best restaurants, venues, and more, based on your location.") {
                    model.getUserLocation()
                    dismiss()
                }
                .tag(1)
                .ignoresSafeArea()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                
                HStack(spacing: 16) {
                    Spacer()
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 0 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 1 ? .white : .gray)
                    
                    Spacer()
                }
                .padding(.bottom, 220)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
        .environment(BusinessModel())
}
