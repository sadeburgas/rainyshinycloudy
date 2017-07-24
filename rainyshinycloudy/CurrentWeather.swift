//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by sade on 23/7/17.
//  Copyright © 2017 sade. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        
        //Alamofire download
        let curretWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(curretWeatherURL!).responseJSON { response in
            
            let result = response.result
            print("DILYAN: \(response)")
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                    print("DILYAN: The name of city : \(self._cityName)")
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print("DILYAN: The weather is : \(self._weatherType)")
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToCelsius = round(currentTemperature - 273.15)
                        self._currentTemp = kelvinToCelsius
                        print("DILYAN: current temp is : \(self._currentTemp)")
                    }
                }
                
            }
           completed()
        }
        
    }
}
