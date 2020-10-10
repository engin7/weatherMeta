//
//  ViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController {

    var nearbyLocations: [Location] = [Location]()
    private let location = LocationManager.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        location.requestLocationAuthorization()

    }
 
     

}
 
 
