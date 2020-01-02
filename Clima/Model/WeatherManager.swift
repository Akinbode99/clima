//
//  WeatherManager.swift
//  Clima
//
//  Created by Mac on 12/17/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherMangerDelegate {
    func weatherManagerDidUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    
    func weatherManagerDidFailWithError(error: Error)

}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=67925582bad3c8b8887a131f9be454c7"
    
    var delegate: WeatherMangerDelegate?
    
    func fetchWeather(cityName: String){
        let stringURL = "\(weatherURL)&q=\(cityName)"
        performRequest(stringURL)
    }
    
    func performRequest(_ stringURL: String){
        if let url = URL(string: stringURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handleResponse(data:urlResponse:error:))
            task.resume()
        }
       
    }
    
    func handleResponse(data: Data?, urlResponse: URLResponse?, error: Error?){
        if error != nil {
            delegate?.weatherManagerDidFailWithError(error: error!)
            return
        }
        
        if let safeData = data{
            if let weather = parseJSON(safeData){
                delegate?.weatherManagerDidUpdateWeather(weatherManager: self, weather: weather)
            }
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder();
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        }
        catch{
            delegate?.weatherManagerDidFailWithError(error: error)
            return nil
        }
    }
    

}
