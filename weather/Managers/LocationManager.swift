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
    var adressOnce = false
    var delegate: LocationManagerDelegate?
    var location: CLLocation?
    var addressString = ""
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
     }
    
    func putAdress() {
        guard !adressOnce else { return }
        adressOnce = true
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
                     _ = LocationManager.shared
                case .authorizedAlways:
                    manager.startUpdatingLocation()
                default:
                    manager.requestWhenInUseAuthorization()
                    let title = "Location Services Disabled"
                    let message = "Please enable Location Services in Location Settings"

                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let settingsAction = UIAlertAction(title: "Go to Location Settings", style: .default) { (_) -> Void in guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                            if UIApplication.shared.canOpenURL(settingsUrl) {
                                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                    print("Settings opened: \(success)") // Prints true
                                })
                            }
                        }
                    alert.addAction(settingsAction)
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locationOnce else { return }
        location = locations.last 
        locationOnce = true
        putAdress()
        Server.instance.getNearbyCities()
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        delegate?.locationManager(locationManager, didFailWithError: error)
    }

}
