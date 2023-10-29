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
    
    var body: some View {
        @Bindable var model = model
        
        VStack {
            HStack {
                TextField("What are you looking for?", text: $model.query)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // TODO
                } label: {
                    Text("Go")
                }

            }
            
            Picker("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                
                Text("Map")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if selectedTab == 1 {
                MapView()
            } else {
                ListView()
            }
        }
        .onAppear {
            model.getBusinesses()
        }
        .sheet(item: $model.selectedBusiness) { _ in
            BusinessDetailView()
        }
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
