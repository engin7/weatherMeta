//
//  CitiesDetailViewController.swift
//  weather
//
//  Created by Engin KUK on 10.10.2020.
//

import UIKit

class CitiesDetailViewController: UIViewController {

    var tableViewDataSource = WeatherDataSource()
    @IBOutlet weak var detailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.allowsSelection = false
        detailsTableView.dataSource = tableViewDataSource
        detailsTableView.reloadData()
     }
    
 
}
