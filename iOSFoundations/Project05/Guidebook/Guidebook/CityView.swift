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
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(cities) { city in
                        NavigationLink {
                            AttractionView(city: city)
                        } label: {
                            CityCard(city: city)
                                .padding(.bottom, 20)
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
