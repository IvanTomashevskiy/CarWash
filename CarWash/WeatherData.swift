//
//  WetherData.swift
//  CarWash
//
//  Created by Иван on 15.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let city: City
    let list: [List]
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct List: Codable{
    struct Main: Codable {
        let temp: Double
    }
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
    }
    let main: Main
    let weather: [Weather]
}

struct City: Codable{
    let name: String
}

