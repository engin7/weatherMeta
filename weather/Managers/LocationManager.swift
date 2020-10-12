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
    var places: [MKMapItem] = []
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
      }
  
    func search(location: CLLocation, queries: [String], index: Int) {
            let request = MKLocalSearch.Request()
            let coordinate = location.coordinate
            request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1600, longitudinalMeters: 1600)
               request.naturalLanguageQuery = queries[index]
            MKLocalSearch(request: request).start { [self] (response, error) in
                   guard error == nil else { return }
                   guard let response = response else { return }
                   guard response.mapItems.count > 0 else { return }

                   for item in response.mapItems {
                    places.append(item)
                    
                   }

                   if index != 0 {
                    self.search(location: location, queries: queries, index: index - 1)
                   } else {
                    NotificationCenter.default.post(name: Notification.Name("searchCompleted"), object: nil)
                   }
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
        guard let lastLocation = locations.last else { return }
        location = lastLocation
        locationOnce = true
        let queries =  ["restaurants", "places", "hotel", "museum", "cafe"]
        search(location: location!, queries: queries, index: queries.count-1)
        let coordinates = String("\(location!.coordinate.latitude),\(location!.coordinate.longitude)")
        let currentLocationModel = Location(title: nil, location_type: nil, latt_long: coordinates, woeid: nil)
        Server.instance.getNearbyCities(location: currentLocationModel)
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        delegate?.locationManager(locationManager, didFailWithError: error)
    }

}
