//
//  Server.swift
//  weather
//
//  Created by Engin KUK on 11.10.2020.
//

import UIKit

class Server {  // to load nearByCities as soon as you get coordinates
    
    static let instance = Server()
    private let networkManager = NetworkManager.shared
    private let location = LocationManager.shared.location?.coordinate
    var listingComplete = false
     
    func getNearbyCities(location: Location){
        networkManager.get(get: .nearbyCities, location: location, completion: { [self] success in
            if success {
                listingComplete = true
            } else {
                 showNetworkError()
        }
    })
    }
    
    // MARK:- Helper Methods
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Server. Please check your connection and try again.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Retry", style: .default, handler: {
        (UIAlertAction) in
        let location = LocationManager.shared.location
        let coordinates = String("\(location?.coordinate.latitude),\(location?.coordinate.longitude)")
        let currentLocationModel = Location(title: nil, location_type: nil, latt_long: coordinates, woeid: nil)
        self.getNearbyCities(location: currentLocationModel)
        })
        alert.addAction(action)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    }
    
 
 
