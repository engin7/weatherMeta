# weatherMeta

## About

This app consists of 3 screens:

Nearby Places:
App gets GPS location of the user by using CoreLocation framework and then lists locations nearby by using MapKit's MKLocalSearch.Request object. 

Nearby Cities:
GPS location used search shows nearby Cities via connecting to metaWeather API.

Weekly Weather Report:
Weekly weather details of chosen city by getting id of the object and using this id as path parameter for the API.  

MVVM design pattern is used. No external libraries were used. 
Native Frameworks used are UIKit, CoreLocation and Mapkit. 

 <img width="200" alt="Nearby Places" src="https://user-images.githubusercontent.com/32449276/95692646-ee8ac480-0c2f-11eb-87f0-2fce7d7506db.png"> <img width="200" alt="Nearby Cities" src="https://user-images.githubusercontent.com/32449276/95692654-f8142c80-0c2f-11eb-9388-170226e07ff4.png"> <img width="200" alt="Weekly Report" src="https://user-images.githubusercontent.com/32449276/95692650-f480a580-0c2f-11eb-8ba3-f9ae9e987059.png">
  
## Requirements

 Minimum IOS deployment target 13.0 and support both Iphone and Ipad. 
 No 3rd party libraries were used for this app.
 XCode 12 Swift 5.3
 
 ## License

This app is open source. If you find a bug please open an issue. Feel free to contribute.
