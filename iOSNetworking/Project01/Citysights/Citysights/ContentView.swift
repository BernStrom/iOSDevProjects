//
//  ContentView.swift
//  Citysights
//
//  Created by Bern N on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var businesses = [Business]()
    @State private var query = ""
    @State private var selectedBusiness: Business?
    
    var service = DataService()
    
    var body: some View {
        VStack {
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // TODO
                } label: {
                    Text("Go")
                }

            }
            
            List {
                ForEach(businesses) { business in
                    VStack(spacing: 20) {
                        HStack(spacing: 0) {
                            Image("list-placeholder-image")
                                .padding(.trailing, 16)
                            
                            VStack(alignment: .leading) {
                                Text(business.name ?? "Restaurant")
                                    .font(.system(size: 15))
                                    .bold()
                                Text("\(TextHelper.distanceAwayText(meters: business.distance ?? 0))")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                            }
                            
                            Spacer()
                            
                            Image("regular_\(business.rating ?? 0)")
                        }
                        
                        Divider()
                    }
                    .onTapGesture {
                        selectedBusiness = business
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .task {
            businesses = await service.businessSearch()
        }
        .sheet(item: $selectedBusiness) { item in
            BusinessDetailView(business: item)
        }
    }
}

#Preview {
    ContentView()
}
