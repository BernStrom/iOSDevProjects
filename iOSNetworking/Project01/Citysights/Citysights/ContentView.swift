//
//  ContentView.swift
//  Citysights
//
//  Created by Bern N on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var query = ""
    var service = DataService()
    
    var body: some View {
        HStack {
            TextField("What are you looking for?", text: $query)
                .textFieldStyle(.roundedBorder)
            
            Button {
                // TODO
            } label: {
                Text("Go")
            }

        }
        .padding()
        .task {
            await service.businessSearch()
        }
    }
}

#Preview {
    ContentView()
}
