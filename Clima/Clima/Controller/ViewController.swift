//
//  ViewController.swift
//  Clima
//
//  Created by Binod Sahoo on 29/10/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UITextFieldDelegate, WeatherDelegateManager {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var wheatherIamge: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    var httpUtilities = HttptUtilities()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        httpUtilities.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.clearButtonMode = .whileEditing
        
        
    }
    
    
    @IBAction func searchBtn(_ sender: UIButton) {
        if let cityNames = searchTextField.text {
            httpUtilities.fetchData(cityName: cityNames)
        }
    }
    
    @IBAction func currentLocationBtn(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func didUpdateWeather(weather: WeatherReport) {
        DispatchQueue.main.async {
            self.wheatherIamge.image = UIImage(systemName: weather.weather[0].conditionName)
            self.temperatureLabel.text = "\(weather.main.temperature)"
            self.cityName.text = weather.name
        }
        print(weather.weather[0].conditionName)
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let cityNames = searchTextField.text {
            httpUtilities.fetchData(cityName: cityNames)
            
            
        }
        return true
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print(lat,long)
            httpUtilities.fetchData(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

