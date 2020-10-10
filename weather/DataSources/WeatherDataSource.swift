//
//  WeatherDataSource.swift
//  weather
//
//  Created by Engin KUK on 10.10.2020.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    private let cityWeather = NetworkManager.shared.cityById?.consolidatedWeather
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityWeather?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.day.text = cityWeather?[indexPath.row].applicable_date
        cell.weatherImage.loadImageUsingCache(withUrl: cityWeather?[indexPath.row].weather_state_abbr ?? "")
        return  cell
    }
}
