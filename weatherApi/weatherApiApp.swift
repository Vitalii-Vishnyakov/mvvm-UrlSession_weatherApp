//
//  weatherApiApp.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//

import SwiftUI

@main
struct weatherApiApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherView(viewModel: viewModel)
        }
    }
}
