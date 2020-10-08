//
//  CitiesDataSource.swift
//  weather
//
//  Created by Engin KUK on 8.10.2020.
//

import Foundation
import UIKit

class CitiesDataSource: NSObject, UITableViewDataSource {
    
    private let network = NetworkManager.shared

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return network.citiesNearby.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CitiesTableViewCell
        cell.city.text = network.citiesNearby[indexPath.row].title
        return  cell
    }
}
