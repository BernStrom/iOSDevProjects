//
//  DataService.swift
//  Citysights
//
//  Created by Bern N on 10/21/23.
//

import Foundation
import CoreLocation

struct DataService {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch(userLocation: CLLocationCoordinate2D?) async -> [Business] {
        guard apiKey != nil else {
            return [Business]()
        }
        
        // Default latitude & longitude
        var lat = 37.785834
        var long = -122.406417
        
        // User's latitude & longitude
        if let userLocation {
            lat = userLocation.latitude
            long = userLocation.longitude
        }
        
        if let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)&categories=restaurants&limit=10") {
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data)
                
                return result.businesses
            } catch {
                print(error)
            }
        }
        
        return [Business]()
    }
}
