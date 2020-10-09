//
//  CitiesViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit

class CitiesViewController: UIViewController, UITableViewDelegate {

    private let tableViewDataSource = CitiesDataSource()
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager.shared
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.dataSource =  tableViewDataSource
        locationManager.locationOnce = false
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(getNearbyCities), name: Notification.Name("locationOK"), object: nil)
        }
    
    @objc func getNearbyCities(){
        networkManager.get(get: .nearbyCities, location: nil, completion: {success in
            if success {
                self.citiesTableView.reloadData()
                // add HUD
            }
        })
    }
    
     
    }
    
    // select row for details
