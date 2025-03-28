//
//  LocationManager.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 27/03/25.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var location: CLLocationCoordinate2D?
   
    override init() {
        super.init()
        manager.delegate = self
       // manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
        //manager.distanceFilter = 5.0
        
        
        // Remove
        //manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationStatus = manager.authorizationStatus
            startUpdatingLocation()
        case .restricted, .denied:
            authorizationStatus = manager.authorizationStatus
            stopUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let latestLocation = locations.last {
            location = latestLocation.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update error: \(error.localizedDescription)")
    }

    var latitude: CLLocationDegrees {
        return location?.latitude ?? 0
    }

    var longitude: CLLocationDegrees {
        return location?.longitude ?? 0
    }
}
