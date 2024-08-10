//
//  WeatherViewModel.swift
//  MyWeatherApp
//
//  Created by sailesh adhikari on 10/08/24.
//

import Foundation

class WeatherViewModel {
    private var weather: Weather? {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }

    var bindWeatherViewModelToController: (() -> ()) = {}

    func fetchWeather(for city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=YOUR_API_KEY&units=metric"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    self.weather = Weather(cityName: weatherResponse.name,
                                           temperature: weatherResponse.main.temp,
                                           description: weatherResponse.weather.first?.description ?? "")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    func getCityName() -> String {
        return weather?.cityName ?? ""
    }

    func getTemperature() -> String {
        guard let temperature = weather?.temperature else { return "" }
        return String(format: "%.1f °C", temperature)
    }

    func getDescription() -> String {
        return weather?.description.capitalized ?? ""
    }
}

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [WeatherDetail]
}

struct Main: Codable {
    let temp: Double
}

struct WeatherDetail: Codable {
    let description: String
}

