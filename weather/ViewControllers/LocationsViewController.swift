//
//  ViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController {

    private let locationManager = LocationManager.shared
    
    @IBOutlet weak var adress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestLocationAuthorization()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reverseGeoCoding), name: Notification.Name("adressOK"), object: nil)
    }
    
    @objc func reverseGeoCoding() {
        adress.text = locationManager.addressString
    }
     

}
 
 
