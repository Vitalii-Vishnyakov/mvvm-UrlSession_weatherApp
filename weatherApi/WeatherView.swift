//
//  ContentView.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel : WeatherViewModel
    
    
    var body: some View {
        VStack{
            Text(viewModel.cityName).font(.largeTitle).padding()
            Text(viewModel.temp).font(.system(size: 70)).bold()
            Text(viewModel.weatherIcon).font(.largeTitle).padding()
            Text(viewModel.weatherDescription)
        }.onAppear(perform: viewModel.update)
    }
}

