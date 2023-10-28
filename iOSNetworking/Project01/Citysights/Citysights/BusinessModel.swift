//
//  BusinessModel.swift
//  Citysights
//
//  Created by Bern N on 10/28/23.
//

import SwiftUI

@Observable
class BusinessModel {
    
    var businesses = [Business]()
    var query = ""
    var selectedBusiness: Business?
    
    var service = DataService()
    
    func getBusinesses() {
        Task {
            businesses = await service.businessSearch()
        }
    }
}
