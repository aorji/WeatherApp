//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Anastasiia ORJI on 9/12/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    
    func updateWeatherIcon(condition: Int) -> String {
//      https://openweathermap.org/weather-conditions
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...600 :
            return "rain"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm1"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm1"
            
        case 903 :
            return "snow4"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
    
}
