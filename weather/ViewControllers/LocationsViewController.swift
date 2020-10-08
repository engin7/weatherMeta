//
//  ViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit
import CoreLocation

class LocationsViewController: UITableViewController {

    var nearbyLocations: [Location] = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.delegate = self
        LocationManager.shared.requestLocationAuthorization()
        
    }

    
    
    func fetchCoordinatesData() {
 
        if CLLocationManager.locationServicesEnabled() {
            LocationManager.shared.requestLocation(completionHandler: { [weak self] in
                var coordinate: String? = nil
         
            })
        }
    }

}



extension LocationsViewController: LocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            fetchCoordinatesData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorAlert = UIAlertController(title: "Location", message: "We were unable to obtain your location. Please, make sure you authorized us to obtain it.", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlert, animated: true, completion: nil)
     }
    
   
   
}
