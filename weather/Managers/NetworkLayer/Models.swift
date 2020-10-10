//
//  Models.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import Foundation

// Network Response
    
struct Location: Codable {
    let title: String?
    let location_type: String?
    let latt_long: String?
    let woeid: Int?
}

struct LocationDetails: Codable {
    
    let consolidatedWeather: [ConsolidatedWeather]
    let time: String
    let title: String
    let woeid: Int
    
    private enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case time,title,woeid
    }
    
    struct ConsolidatedWeather: Codable {
        let id: Int
        let weather_state_name: String
        let weather_state_abbr: String
        let wind_direction_compass: String
        let created: String
        let applicable_date: String
        let min_temp: Double
        let max_temp: Double
        let the_temp: Double
        let wind_speed: Double
        let wind_direction: Double
        let air_pressure: Double
        let humidity: Int
        let visibility: Double
        let predictability: Int
    }
    
    
}
