//
//  MapView.swift
//  Citysights
//
//  Created by Bern N on 10/29/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(BusinessViewModel.self) private var model
    @State private var selectedBusinessId: String?
    
    var body: some View {
        Map(selection: $selectedBusinessId) {
            ForEach(model.businesses) { business in
                Marker(business.name ?? "Restaurant", coordinate: CLLocationCoordinate2D(latitude: business.coordinates?.latitude ?? 0, longitude: business.coordinates?.longitude ?? 0))
                    .tag(business.id ?? "None")
            }
        }
        .onChange(of: selectedBusinessId) { oldValue, newValue in
            let business = model.businesses.first { business in
                business.id == selectedBusinessId
            }
            
            if let business = business {
                model.selectedBusiness = business
            }
        }
    }
}

#Preview {
    MapView()
        .environment(BusinessViewModel())
}
