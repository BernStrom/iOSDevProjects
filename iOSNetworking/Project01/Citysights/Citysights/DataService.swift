//
//  DataService.swift
//  Citysights
//
//  Created by Bern N on 10/21/23.
//

import Foundation

struct DataService {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch() async {
        guard apiKey != nil else {
            return
        }
        
        if let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=37.785834&longitude=-122.406417&categories=restaurants&limit=10") {
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            do {
                let (data,response) = try await URLSession.shared.data(for: request)
                
                print(data)
                print(response)
            } catch {
                print(error)
            }
            
        }
    }
}
