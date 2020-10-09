//
//  LocationManager.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
}

class LocationManager: NSObject {
    
    static let shared: LocationManager = LocationManager() //singleton
    private let locationManager: CLLocationManager = CLLocationManager()
    var locationOnce = false

    var delegate: LocationManagerDelegate?
    var location: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
     }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func stopLocationManager() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    func startLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
                case .notDetermined:
                    manager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse:
                    manager.startUpdatingLocation()
                case .authorizedAlways:
                    manager.startUpdatingLocation()
                default:
                    requestLocationAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locationOnce else { return }
        location = locations.last 
        locationOnce = true
        NotificationCenter.default.post(name: Notification.Name("locationOK"), object: nil)
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        delegate?.locationManager(locationManager, didFailWithError: error)
    }
}
