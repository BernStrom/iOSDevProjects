//
//  MenuView.swift
//  Restaurant
//
//  Created by Bern N on 10/8/23.
//

import SwiftUI

struct MenuView: View {
    @State private var menuItems: [MenuItem] = [MenuItem]()
    var dataService = DataService()
    
    var body: some View {
        List(menuItems) { item in
            MenuListRow(item: item)
        }
        .listStyle(.plain)
        .onAppear {
            menuItems = dataService.getData()
        }
    }
}

#Preview {
    MenuView()
}
