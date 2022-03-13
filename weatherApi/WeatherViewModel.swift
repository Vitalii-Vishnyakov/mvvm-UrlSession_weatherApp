//
//  WeathweViewModel.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//

import Foundation

private let defualtIcon = "☀️"
private let iconMap = ["Drizzle" : "🌧" , "Thunderstorm" : "⛈" , "Rain" : "🌧" , "Snow" : "❄️" , "Clear" : "☀️" , "Clouds" : "☁️🌧" ,  ]



public class WeatherViewModel : ObservableObject{
    @Published var cityName : String = "Los Angeles"
    @Published var temp : String = "30" + "℃"

    @Published var weatherDescription   : String = "Clear"
    @Published var weatherIcon : String = defualtIcon
    public let weatherService : WeatherService
    
    public init (weatherService : WeatherService){
        self.weatherService = weatherService
    }
    
    public func update(){
        weatherService.loadWeatherData { weather  in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temp = weather.temp + "℃"
                self.weatherDescription = weather.description
                self.weatherIcon = iconMap[weather.iconName] ?? defualtIcon
            }
        }
    }
}
