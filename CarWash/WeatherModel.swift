//
//  WeatherModel.swift
//  CarWash
//
//  Created by Иван on 15.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let weatherMain: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
        }
    }
    
    var conditionMain: String {
           switch weatherMain {
           case "Rain":
            return "Сегодня будет дождь, мы не советуем вам мыть машину."
            
           case "Clear":
            return "Сегодня прекрасная погода, мы советуем вам мыть машину."
           case "Clouds":
            return "Сегодня облачно, мы советуем вам мыть машину."
                     
           default:
               return "Ошибка"
           }
       }
}
