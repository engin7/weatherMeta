//
//  WeatherDataSource.swift
//  weather
//
//  Created by Engin KUK on 10.10.2020.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    private let networkManager = NetworkManager.shared

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return networkManager.cityById?.consolidatedWeather.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.day.text = networkManager.cityById?.consolidatedWeather[indexPath.row].applicable_date
        return  cell
    }
}
