//
//  BusinessModel.swift
//  Citysights
//
//  Created by Bern N on 10/28/23.
//

import SwiftUI
import CoreLocation

@Observable
final class BusinessModel: NSObject, CLLocationManagerDelegate {
    
    var businesses = [Business]()
    var query = ""
    var selectedBusiness: Business?
    
    var service = DataService()
    var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func getBusinesses() {
        Task {
            businesses = await service.businessSearch(userLocation: currentUserLocation)
        }
    }
    
    func getUserLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentUserLocation == nil {
            currentUserLocation = locations.last?.coordinate
            getBusinesses()
        }
        
        manager.stopUpdatingLocation()
    }
    
}
