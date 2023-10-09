//
//  PhotoView.swift
//  Restaurant
//
//  Created by Bern N on 10/9/23.
//

import SwiftUI

struct PhotoView: View {
    @Binding var selectedPhoto: String
    @Binding var sheetVisible: Bool
    
    var body: some View {
        ZStack {
            Image(selectedPhoto)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        sheetVisible = false
                    } label: {
                        Image(systemName: "x.circle")
                            .scaleEffect(2)
                            .foregroundStyle(.brown)
                            .opacity(0.9)
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .background(.ultraThinMaterial)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    PhotoView(selectedPhoto: .constant("gallery1"), sheetVisible: .constant(true))
}
