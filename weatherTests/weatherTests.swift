//
//  weatherTests.swift
//  weatherTests
//
//  Created by Engin KUK on 6.10.2020.
//

import XCTest
@testable import weather

class weatherTests: XCTestCase {
    
    var sut : NetworkManager! //System Under Test

    override func setUpWithError() throws {
       
        sut = NetworkManager.shared

    }

    override func tearDownWithError() throws {
        sut = nil
     }

    func testExample() throws {
        
        let location = Location(title: "London", location_type: "city", latt_long: "test", woeid: 44418)
        let promise = expectation(description: "Status code: 200")

        sut.get(get: .detailsId, location: location, completion: { [self]success in
            if success {
                let weatherWeek = sut.cityById?.consolidatedWeather
                let dayMax = Int(weatherWeek?.first?.max_temp ?? 0)
                let dayMin = Int(weatherWeek?.first?.min_temp ?? 0)
                
                //  min degrees smaller than max
                XCTAssertLessThanOrEqual(dayMin, dayMax)
                promise.fulfill()

             }
        })
          
            wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
