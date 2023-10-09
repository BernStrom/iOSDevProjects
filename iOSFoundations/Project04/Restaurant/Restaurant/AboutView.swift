//
//  AboutView.swift
//  Restaurant
//
//  Created by Bern N on 10/8/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Image("restaurant-inside")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom)
                    
                    Text("""
                        Sukiyabashi Jiro (すきやばし次郎, Sukiyabashi Jirō) is a sushi restaurant in Ginza, Chūō, Tokyo, Japan. It is owned and operated by sushi master Jiro Ono. It was the first sushi restaurant in the world to receive three stars from the Michelin Guide.

                        A two-star branch operated by his son Takashi is located at Roppongi Hills in Minato, Tokyo. The late French chef Joël Robuchon said that the restaurant was one of his favorites in the world, and that it taught him that sushi is an art.
                        """)
                    
                    Image("map")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom)
                    
                    Text("""
                         Tsukamoto Sogyo Building
                         Basement Floor 1
                         2-15, Ginza 4-chome
                         Chūō, Tokyo
                         """)
                }
                .padding(.horizontal)
            }
            .navigationTitle("About")
        }
    }
}

#Preview {
    AboutView()
}
