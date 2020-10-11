//
//  WeatherDataSource.swift
//  weather
//
//  Created by Engin KUK on 10.10.2020.
//

import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    var cityWeather: [LocationDetails.ConsolidatedWeather] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityWeather.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.day.text = cityWeather[indexPath.row].applicable_date
          let minTemp = cityWeather[indexPath.row].min_temp
          let maxTemp = cityWeather[indexPath.row].max_temp
            cell.temp.text = String(format:"%.1f",maxTemp) + "C° / " + String(format:"%.1f",minTemp) + "C°"
         
        cell.weatherImage.loadImageUsingCache(withUrl: cityWeather[indexPath.row].weather_state_abbr)
        return  cell
    }
}
