//
//  BusinessDetailView.swift
//  Citysights
//
//  Created by Bern N on 10/23/23.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business?
    
    var body: some View {
        Text(business?.name ?? "")
    }
}

#Preview {
    BusinessDetailView()
}
