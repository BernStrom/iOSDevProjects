//
//  ListView.swift
//  Citysights
//
//  Created by Bern N on 10/29/23.
//

import SwiftUI

struct ListView: View {
    @Environment(BusinessViewModel.self) private var model
    
    var body: some View {
        List {
            ForEach(model.businesses) { business in
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        if let imageUrl = business.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)!) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .padding(.trailing, 16)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        } else {
                            Image("list-placeholder-image")
                                .padding(.trailing, 16)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(business.name ?? "Restaurant")
                                .font(.system(size: 15))
                                .bold()
                            Text("\(TextHelper.distanceAwayText(meters: business.distance ?? 0))")
                                .font(.system(size: 16))
                                .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                        }
                        
                        Spacer()
                        
                        Image("regular_\(business.rating ?? 0.0)")
                    }
                    
                    Divider()
                }
                .onTapGesture {
                    model.selectedBusiness = business
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListView()
        .environment(BusinessViewModel())
}
