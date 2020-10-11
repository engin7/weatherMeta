//
//  LocationsDataSource.swift
//  weather
//
//  Created by Engin KUK on 11.10.2020.
//

import UIKit
import MapKit

class LocationsDataSource: NSObject, UITableViewDataSource {
    
    private let locationManager = LocationManager.shared

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return locationManager.places.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = locationManager.places[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationsTableViewCell
        cell.place.text = item.name
        let adress = lookUpCurrentLocation(placemark: item.placemark)
        cell.adress.text = adress
        cell.phone.text = item.phoneNumber
        return  cell
    }
    
    func lookUpCurrentLocation(placemark: MKPlacemark?) -> String {
        var addressString = ""
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
        return addressString
    }
}

