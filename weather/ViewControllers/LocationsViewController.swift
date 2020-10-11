//
//  ViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController, Loadable {

    private let locationManager = LocationManager.shared
    private let tableViewDataSource = LocationsDataSource()
    @IBOutlet weak var locationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsTableView.allowsSelection = false
        self.title = "Nearby Places"
        showLoadingView()
        locationsTableView.dataSource = tableViewDataSource
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reverseGeoCoding), name: Notification.Name("searchCompleted"), object: nil)
    }
    
    @objc func reverseGeoCoding() {

        self.hideLoadingView()
        locationsTableView.reloadData()
    }

}
 
 
