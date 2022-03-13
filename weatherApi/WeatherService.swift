//
//  WeatherService.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//


//{
//  "coord": {
//    "lon": -122.08,
//    "lat": 37.39
//  },
//  "weather": [
//    {
//      "id": 800,
//      "main": "Clear",
//      "description": "clear sky",
//      "icon": "01d"
//    }
//  ],
//  "base": "stations",
//  "main": {
//    "temp": 282.55,
//    "feels_like": 281.86,
//    "temp_min": 280.37,
//    "temp_max": 284.26,
//    "pressure": 1023,
//    "humidity": 100
//  },
//  "visibility": 16093,
//  "wind": {
//    "speed": 1.5,
//    "deg": 350
//  },
//  "clouds": {
//    "all": 1
//  },
//  "dt": 1560350645,
//  "sys": {
//    "type": 1,
//    "id": 5122,
//    "message": 0.0139,
//    "country": "US",
//    "sunrise": 1560343627,
//    "sunset": 1560396563
//  },
//  "timezone": -25200,
//  "id": 420006353,
//  "name": "Mountain View",
//  "cod": 200
//  }
import CoreLocation
import Foundation
import SwiftUI

public final class WeatherService : NSObject {
    private let locationManager = CLLocationManager()
    private let key = "b245ceaa524b02630049965b98a73d70"
    private var completionHandler : ((Weather) -> Void)?
    
    public override init ( ){
        super.init()
        locationManager.delegate = self
    }
    
    
    public func loadWeatherData ( _ completionHandler : @escaping( (Weather) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(for coords : CLLocationCoordinate2D ){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(key)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            guard error == nil , let data = data else {
                print("error in urlsesstio")
                return
            }
            if let response = try? JSONDecoder().decode(apiRespons.self, from : data){
                
                self.completionHandler?(Weather(responses: response))
            }
            else {
                print("cant decode json")
            }
            
            
            
        }.resume()
    }
    
}
extension WeatherService : CLLocationManagerDelegate{
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        makeDataRequest(for: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("something fail when get local")
    }
    
}

struct apiRespons : Decodable{
    let name : String
    let main : apiMain
    let weather : [apiWeather]
    
}

struct apiMain : Decodable {
    let temp : Double
    
}


struct apiWeather : Decodable {
    
    var description : String
    var iconName : String
    enum CodingKeys : String , CodingKey {
        case  description
        case iconName  = "main"
    }
    
}


