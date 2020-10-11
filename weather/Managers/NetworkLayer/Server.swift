//
//  Server.swift
//  weather
//
//  Created by Engin KUK on 11.10.2020.
//

import UIKit

class Server {  // to load nearByCities as soon as you get coordinates
    
    static let instance = Server()
    private let networkManager = NetworkManager.shared

    func getNearbyCities(){
        networkManager.get(get: .nearbyCities, location: nil, completion: {success in
            if success {
                NotificationCenter.default.post(name: Notification.Name("locationOK"), object: nil)
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
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    }
    
 
 
