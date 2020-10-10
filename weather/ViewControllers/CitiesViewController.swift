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
            } else {
                self.showNetworkError()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let result = networkManager.citiesNearby[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! CitiesDetailViewController
         
        networkManager.get(get: .detailsId, location: result, completion: {success in
            if success {
                vc.tableViewDataSource.cityWeather = self.networkManager.cityById?.consolidatedWeather
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showNetworkError()
            }
        })
       }
    
    // MARK:- Helper Methods
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Server. Please check your connection and try again.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Retry", style: .default, handler: {
        (UIAlertAction) in
        self.getNearbyCities()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    }
    
 
