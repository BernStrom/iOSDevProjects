//
//  ContentView.swift
//  Citysights
//
//  Created by Bern N on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(BusinessModel.self) private var model
    
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
            
            List {
                ForEach(model.businesses) { business in
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
                        model.selectedBusiness = business
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
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
    ContentView()
}
