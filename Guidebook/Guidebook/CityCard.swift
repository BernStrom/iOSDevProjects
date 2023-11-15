//
//  CityCard.swift
//  Guidebook
//
//  Created by Bern N on 10/14/23.
//

import SwiftUI

struct CityCard: View {
    var city: City
    
    var body: some View {
        ZStack {
            Rectangle()
                .background {
                    Image(city.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .foregroundStyle(.clear)
                .cornerRadius(15)
            
            Rectangle()
                .foregroundStyle(.black)
                .opacity(0.5)
                .cornerRadius(15)
            
            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Text(city.summary)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .foregroundStyle(.white)
        }
        .frame(height: 400)
    }
}

#Preview {
    CityCard(city: City(
        name: "Rome",
        summary: "Rome is the capital city of Italy. It is also the capital of the Lazio region, the centre of the Metropolitan City of Rome, and a special comune named Comune di Roma Capitale.",
        imageName: "rome",
        attractions: [
            Attraction(
                name: "Pantheon",
                summary: "The Pantheon is a former Roman temple and, since 609 AD, a Catholic church in Rome, Italy, on the site of an earlier temple commissioned by Marcus Agrippa during the reign of Augustus.",
                longDescription: """
The Pantheon from Greek is a former Roman temple and, since 609 AD, a Catholic church (Basilica di Santa Maria ad Martyres or Basilica of St. Mary and the Martyrs) in Rome, Italy, on the site of an earlier temple commissioned by Marcus Agrippa during the reign of Augustus (27 BC – 14 AD). It was rebuilt by the emperor Hadrian and probably dedicated c. 126 AD. Its date of construction is uncertain, because Hadrian chose not to inscribe the new temple but rather to retain the inscription of Agrippa's older temple, which had burned down.
""",
                imageName: "pantheon",
                latLong: "41.898762500696236, 12.476915812472798"
            )
        ]
    ))
}
