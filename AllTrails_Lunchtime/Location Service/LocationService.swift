//
//  LocationService.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import Foundation
import CoreLocation

protocol LocationUpdated : NSObjectProtocol {
    func updateLocation(location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    lazy var locationManager = CLLocationManager()
    weak var delegate: LocationUpdated?
    func requestAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        self.locationManager.activityType = .other
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
    }

    // DELEGATE
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            self.requestLocation()
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            self.delegate?.updateLocation(location: lastLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("cannot show location")
    }
    
    
}
