//
//  WeatherModel.swift
//  Clima
//
//  Created by Binod Sahoo on 29/10/22.
//

import Foundation


// MARK: - Welcome
struct WeatherReport: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    var temperature : String {
        return String(format: "%.1f", temp)
    }
}

struct Weather: Codable {
    let description: String
    let id: Int
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
