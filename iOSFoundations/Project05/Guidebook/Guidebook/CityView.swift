//
//  CityView.swift
//  Guidebook
//
//  Created by Bern N on 10/12/23.
//

import SwiftUI

struct CityView: View {
    @State private var cities = [City]()
    var dataService = DataService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(cities) { city in
                        NavigationLink {
                            AttractionView(city: city)
                        } label: {
                            Text(city.name)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                cities = dataService.getData()
            }
        }
    }
}

#Preview {
    CityView()
}
