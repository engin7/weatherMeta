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
    
    enum CategoryEnum: String {
        case cafe  = "MKPOICategoryCafe"
        case hotel = "MKPOICategoryHotel"
        case restaurant = "MKPOICategoryRestaurant"
        case museum = "MKPOICategoryMuseum"
    }
 
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
        let category = CategoryEnum(rawValue: item.pointOfInterestCategory?.rawValue ?? "")
        cell.categoryImageView.image = setIcon(category: category)
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
    
    func setIcon(category: CategoryEnum?) -> UIImage {
        
        switch category{
        
        case .cafe:
            return #imageLiteral(resourceName: "cafe.png")
        case .hotel:
            return #imageLiteral(resourceName: "hotel.png")
        case .restaurant:
            return #imageLiteral(resourceName: "restaurant.png")
        case .museum:
            return #imageLiteral(resourceName: "museum.png")
        default:
            return #imageLiteral(resourceName: "place.png")
        }
    }
    
}

