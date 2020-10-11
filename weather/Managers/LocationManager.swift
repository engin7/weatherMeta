//
//  LocationManager.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit
import CoreLocation
import MapKit

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
    var addressString = ""
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        lookUpCurrentLocation(completionHandler: { [self]placemark in
            if placemark?.subLocality != nil {
                 addressString = addressString + (placemark?.subLocality)! + ", "
            }
            if placemark?.thoroughfare != nil {
                addressString = addressString + (placemark?.thoroughfare)! + ", "
            }
            if placemark?.locality != nil {
                addressString = addressString + (placemark?.locality)! + ", "
            }
            if placemark?.country != nil {
                addressString = addressString + (placemark?.country)! + ", "
            }
            if placemark?.postalCode != nil {
                addressString = addressString + (placemark?.postalCode)! + " "
            }
            NotificationCenter.default.post(name: Notification.Name("adressOK"), object: nil)
        })
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
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                                -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
                                            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
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
                    let title = "Location Services Disabled"
                    let message = "Please enable Location Services in Settings"

                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)

                    alert.addAction(action)
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
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
