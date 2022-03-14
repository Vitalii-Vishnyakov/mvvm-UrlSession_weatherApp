//
//  ContentView.swift
//  weatherApi
//
//  Created by Виталий on 13.03.2022.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel : WeatherViewModel
    @State private var isUpdate = true
        
    
    
    var body: some View {
        
            
        VStack{
            HStack{
                Spacer( )
                Toggle(isUpdate ? "Update" : "No Update", isOn: $isUpdate ).toggleStyle(.button).tint(.mint).animation(.easeIn, value: isUpdate).padding().onChange(of: isUpdate) { newValue in
                    viewModel.isUpdate = newValue
                }
                
            }
            Spacer()
            Text(viewModel.cityName).font(.largeTitle).padding()
            Text(viewModel.temp).font(.system(size: 70)).bold()
            Text(viewModel.weatherIcon).font(.largeTitle).padding()
            Text(viewModel.weatherDescription)
            Spacer()
        }.onAppear(perform: viewModel.startFetch)
    
        
        }
}

