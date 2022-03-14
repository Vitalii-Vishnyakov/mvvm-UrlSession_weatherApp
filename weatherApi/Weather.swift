//
//  Weather.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//

import Foundation

public struct Weather  : Codable{
    let city : String
    let temp : String
    let description : String
    let iconName : String
    init (responses : apiRespons){
        city = responses.name
        temp = "\(Int(responses.main.temp))"
        description = responses.weather.first?.description ?? ""
        iconName = responses.weather.first?.iconName ?? ""
    }
    
    
}


