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
    
    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?, options: String?, category: String?) async -> [Business] {
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
        
        var endpointUrlString = "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)&limit=10"
        
        // Add query term parameter to URL endpoint
        if query != nil && query != "" {
            endpointUrlString.append("&term=\(query!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")
        }
        
        // Add options parameter to URL endpoint
        if options != nil && options != "" {
            endpointUrlString.append("&attributes=\(options!)")
        }
        
        // Add category parameter to URL endpoint
        if let category {
            endpointUrlString.append("&categories=\(category)")
        }
        
        if let url = URL(string: endpointUrlString) {
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data)
                
                print(response.url ?? "API endpoint URL response not found")
                return result.businesses
            } catch {
                print(error)
            }
        }
        
        return [Business]()
    }
}
