//
//  HomeView.swift
//  Citysights
//
//  Created by Bern N on 10/19/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(BusinessModel.self) private var model
    @State private var selectedTab = 0
    
    @State private var query = ""
    @FocusState private var queryBoxFocused: Bool
    
    @State private var showOptions = false
    @State private var popularOn = false
    @State private var dealsOn = false
    @State private var categorySelection = "restaurants"
    
    var body: some View {
        @Bindable var model = model
        
        VStack {
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($queryBoxFocused)
                    .onTapGesture {
                        withAnimation {
                            showOptions = true
                        }
                    }
                
                Button {
                    withAnimation {
                        showOptions = false
                        queryBoxFocused = false
                    }
                    
                    model.getBusinesses(query: query, options: getOptionsString(), category: categorySelection)
                } label: {
                    Text("Go")
                        .padding(.horizontal)
                        .frame(height: 32)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            .padding(.horizontal)
            
            if showOptions {
                VStack {
                    Toggle("Popular", isOn: $popularOn)
                    Toggle("Deals", isOn: $dealsOn)
                    
                    HStack {
                        Text("Category")
                        
                        Spacer()
                        
                        Picker("Category", selection: $categorySelection) {
                            Text("Arts")
                                .tag("arts")
                            
                            Text("Hotels & Travel")
                                .tag("hotelstravel")
                            
                            Text("Nightlife")
                                .tag("nightlife")
                            
                            Text("Restaurants")
                                .tag("restaurants")
                        }
                    }
                }
                .padding(.horizontal, 40)
                .transition(.push(from: .top))
            }
            
            Picker("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                
                Text("Map")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if model.locationAuthStatus == .denied {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Please allow location services for this app to show local sights near you.")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Open App Privacy Settings")
                    }
                    .buttonStyle(.bordered)
                }
                
                Spacer()
            } else if selectedTab == 1 {
                MapView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            queryBoxFocused = false
                        }
                }
            } else {
                ListView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            queryBoxFocused = false
                        }
                    }
            }
        }
        .sheet(item: $model.selectedBusiness) { _ in
            BusinessDetailView()
        }
    }
    
    func getOptionsString() -> String {
        var optionsArray = [String]()
        
        if popularOn {
            optionsArray.append("hot_and_new")
        }
        
        if dealsOn {
            optionsArray.append("deals")
        }
        
        return optionsArray.joined(separator: ",")
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
