//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation



class WeatherViewController: UIViewController{
   
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //locationManager.requestWhenInUseAuthorization()
        //locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}


extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
           searchTextField.endEditing(true)
            print(searchTextField.text!)
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           searchTextField.endEditing(true)
           print(searchTextField.text!)
           
           return true
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           if let city = textField.text{
               weatherManager.fetchWeather(cityName: city)
           }
           searchTextField.text = ""
       }
}


extension WeatherViewController: WeatherMangerDelegate{
    
    func weatherManagerDidUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
       }
    
    
    func weatherManagerDidFailWithError(error: Error) {
           print(error)
       }
}

