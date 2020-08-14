//
//  DataModels.swift
//  Weather
//
//  Created by 17586317 on 30.06.2020.
//  Copyright © 2020 Борисов Сергей Александрович. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String

}

struct Main: Codable {
    var temp: Double = 0.0
    var feels_like: Double = 0.0
//    var temp_min: Int = 0
//    var temp_max: Int = 0
    var pressure: Int = 0
    var humidity: Int = 0
}

struct WeatherData: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name:String=""
    
}
