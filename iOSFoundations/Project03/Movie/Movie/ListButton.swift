//
//  ListButton.swift
//  Movie
//
//  Created by Bern N on 10/7/23.
//

import SwiftUI

struct ListButton: View {
    var title: String
    var borderColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .padding()
                .border(borderColor)
        })
    }
}
