//
//  CitysightsApp.swift
//  Citysights
//
//  Created by Bern N on 10/19/23.
//

import SwiftUI

@main
struct CitysightsApp: App {
    @State private var model = BusinessModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
