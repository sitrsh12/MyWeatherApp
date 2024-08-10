//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by sailesh adhikari on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WeatherViewModel()

    @State private var city: String = ""

    var body: some View {
        VStack {
            TextField("Enter city name", text: $city, onCommit: {
                self.viewModel.fetchWeather(for: self.city)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Text(viewModel.getCityName())
                .font(.largeTitle)
                .padding()

            Text(viewModel.getTemperature())
                .font(.system(size: 50))
                .padding()

            Text(viewModel.getDescription())
                .font(.title)
                .padding()

            Spacer()
        }
        .padding()
        .onAppear {
            // Fetch initial weather data for a default city
            self.viewModel.fetchWeather(for: "New York")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
