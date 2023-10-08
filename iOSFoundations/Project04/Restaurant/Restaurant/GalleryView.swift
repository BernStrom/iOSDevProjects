//
//  GalleryView.swift
//  Restaurant
//
//  Created by Bern N on 10/8/23.
//

import SwiftUI

struct GalleryView: View {
    @State private var photoData = [String]()
    var dataService = DataService()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gallery")
                .font(.largeTitle)
                .bold()
            
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [
                        GridItem(spacing: 10),
                        GridItem(spacing: 10),
                        GridItem(spacing: 10)
                    ], spacing: 10) {
                        ForEach(photoData, id: \.self) { photo in
                            Image(photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: (proxy.size.width - 20) / 3)
                                .clipped()
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            photoData = dataService.getPhotos()
        }
    }
}

#Preview {
    GalleryView()
}
