//
//  WeathweViewModel.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//

import Foundation
import SwiftUI

private let defualtIcon = "☀️"
private let iconMap = ["Drizzle" : "🌧" , "Thunderstorm" : "⛈" , "Rain" : "🌧" , "Snow" : "❄️" , "Clear" : "☀️" , "Clouds" : "☁️" ,  ]



public class WeatherViewModel : ObservableObject{
    let cash = UserDefaults.standard.value(forKey: "cash")
    
    @Published var cityName : String!
    @Published var temp : String!
    @Published var weatherDescription : String!
    @Published var weatherIcon : String!
    @Published var isUpdate : Bool = true
    
    public let weatherService : WeatherService
    
    public init (weatherService : WeatherService) {
        self.weatherService = weatherService
        self.loadCash()
    }
    private func loadCash ( ){
        if let cash = UserDefaults.standard.data(forKey: "cash"){
            if let decodedCash = try? JSONDecoder( ).decode(Weather.self, from: cash){
                self.cityName = decodedCash.city
                self.temp = decodedCash.temp
                self.weatherDescription = decodedCash.description
                self.weatherIcon = decodedCash.iconName
            }
            else {
                print("fail to decod cash ")
            }
            
        }else {
            self.cityName = "Los Angeles"
            self.temp = "30" + "℃"
            self.weatherDescription = "Clear"
            self.weatherIcon = defualtIcon
        }
    }
    @objc private func update(){
        if isUpdate{
            
        weatherService.loadWeatherData { weather  in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temp = weather.temp + "℃"
                self.weatherDescription = weather.description
                self.weatherIcon = iconMap[weather.iconName] ?? defualtIcon
            }
        }
            print("fetch")}
    }
    public func startFetch (){
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
}
