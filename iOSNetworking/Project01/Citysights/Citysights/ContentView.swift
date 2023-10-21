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
            
            List(businesses) { business in
                Text(business.name ?? "N/A")
            }
        }
        .padding()
        .task {
            businesses = await service.businessSearch()
        }
    }
}

#Preview {
    ContentView()
}
