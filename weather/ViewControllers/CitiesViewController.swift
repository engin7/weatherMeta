//
//  CitiesViewController.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit

class CitiesViewController: UIViewController, UITableViewDelegate, Loadable {

    private let tableViewDataSource = CitiesDataSource()
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager.shared
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        self.title = "Nearby Cities"
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Cities", style: .plain, target: nil, action: nil)
        citiesTableView.dataSource =  tableViewDataSource
        locationManager.locationOnce = false
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(getNearbyCities), name: Notification.Name("locationOK"), object: nil)
        }
    
    @objc func getNearbyCities(){
        self.hideLoadingView()
        self.citiesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showLoadingView()
        tableView.deselectRow(at: indexPath, animated: true)
        let result = networkManager.citiesNearby[indexPath.row]
        let identifier = String(describing: CitiesDetailViewController.self)
        let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as! CitiesDetailViewController
         
        networkManager.get(get: .detailsId, location: result, completion: {success in
            if success {
                vc.tableViewDataSource.cityWeather = self.networkManager.cityById?.consolidatedWeather
                vc.title = result.title
                self.hideLoadingView()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showNetworkError()
            }
        })
       }
    
    // MARK:- Helper Methods
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Server. Please check your connection and try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
 
