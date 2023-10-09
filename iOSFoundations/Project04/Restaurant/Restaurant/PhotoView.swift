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
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        sheetVisible = false
                    } label: {
                        Image(systemName: "x.circle")
                            .scaleEffect(2)
                            .foregroundStyle(.black)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    PhotoView(selectedPhoto: .constant("gallery1"), sheetVisible: .constant(true))
}
