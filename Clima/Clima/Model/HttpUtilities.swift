//
//  HttpUtilities.swift
//  Clima
//
//  Created by Binod Sahoo on 29/10/22.
//

import Foundation
import  CoreLocation

protocol WeatherDelegateManager {
    func didUpdateWeather(weather: WeatherReport)
}
//var datasave: WeatherReport?

struct HttptUtilities {
    let weatherApi = "https://api.openweathermap.org/data/2.5/weather?appid=4ac3679a51b6cd809f5b784279783535"
    var delegate: WeatherDelegateManager?
    func fetchData(cityName: String){
        let url = "\(weatherApi)&q=\(cityName)&units=metric"
        print(url)
        performrequest(url: url)
 
    }
    
    func fetchData(latitude: CLLocationDegrees, longitude
                   : CLLocationDegrees){
        let url = "\(weatherApi)&lat=\(latitude)&lon=\(longitude)&units=metric"
        print(url)
        performrequest(url: url)
 
    }
    
    func performrequest(url: String){
        if let urlstring = URL(string: url) {
            let task = URLSession.shared.dataTask(with: urlstring,completionHandler:{(data , response , error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if let savedata = data {
                    let decoder = JSONDecoder()
                    do {
                        
                        let data1 = try decoder.decode(WeatherReport.self, from: savedata)
                        let weatherData1: WeatherReport? = data1
                        if let  weatherData = weatherData1 {
                            self.delegate?.didUpdateWeather(weather: weatherData)
                        }
                      
                        
                    } catch {
                        print(error)
                    }
                }
                
                
            })
            task.resume()
        }
    }
    
}
