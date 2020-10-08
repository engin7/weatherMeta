//
//  CitiesViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit

class CitiesViewController: UIViewController, UITableViewDelegate {

    private let tableViewDataSource = CitiesDataSource()
    private let network = NetworkManager.shared
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.dataSource =  tableViewDataSource
        network.get(get: .nearbyCities, location: nil, completion: {success in
            if success {
                self.citiesTableView.reloadData()
             }
        })
    }
    
    // select row for details
    
}
