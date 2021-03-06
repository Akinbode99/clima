//
//  weatherModel.swift
//  Clima
//
//  Created by Mac on 12/19/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData: Decodable {
    let weather: [Weather]
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
