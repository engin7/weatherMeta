//
//  NetworkManager.swift
//  weather
//
//  Created by Engin KUK on 6.10.2020.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager() // singleton
 
    private let nearbyURL = "https://www.metaweather.com/api/location/search/?lattlong="
    private let byIdURL = "https://www.metaweather.com/api/location/"  
    private var dataTask: URLSessionDataTask? = nil
    
    var cityById:LocationDetails?
    var citiesNearby: [Location] = []
 
    enum GetType {
       case nearbyCities
       case detailsId
     }

    typealias SearchComplete = (Bool) -> Void

    func get(get: GetType, location: Location?, completion: @escaping SearchComplete) {
        
        let url: URL
        
        switch get {
        case .detailsId:
            url = URL(string: byIdURL + String((location?.woeid)!))!
        case .nearbyCities:
            var latlong = ""
            if let coordinate = LocationManager.shared.location?.coordinate {
                latlong = String("\(coordinate.latitude),\(coordinate.longitude)")
            }
            url =  URL(string: nearbyURL + latlong)!
        }
        dataTask?.cancel()
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: {data, response, error in
          // if cancelled ignore error code and return
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                switch get {
                case .detailsId:
                    self.cityById = self.parseId(data: data)
                case .nearbyCities:
                    self.citiesNearby = self.parseNearby(data: data)
                }
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        })
           dataTask?.resume()
    }
    
    // MARK:- Private Methods
   
      private func parseNearby(data: Data) -> [Location] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Location].self, from:data)
            return result
        } catch {
            print("JSON Error: \(error)")
            let empty: [Location] = []
             return  empty  }
    }
    
    private func parseId(data: Data) -> LocationDetails {
           do {
               let decoder = JSONDecoder()
               let result = try decoder.decode(LocationDetails.self, from:data)
               return result
           } catch {
               print("JSON Error: \(error)")
            let empty = LocationDetails(consolidatedWeather: [], time: "", title: "", woeid: 0)
               return  empty  }
       }
}
    
    
 

