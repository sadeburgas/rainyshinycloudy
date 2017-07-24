//
//  ViewController.swift
//  rainyshinycloudy
//
//  Created by sade on 22/7/17.
//  Copyright © 2017 sade. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DILYAN: weather URL is \(CURRENT_WEATHER_URL)")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
        
        currentWeather.downloadWeatherDetails {
            //Setup load dato for UI
            self.downloadForecastData {
                self.updateMainUI()
            }
            
        }
        
       
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        //Download Forecast data for TableView
        
        let forcastURL = URL(string: FORCAST_URL)
        Alamofire.request(forcastURL!).responseJSON {responce in
            let result = responce.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>]{
                   
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print("Dilyan: forecast obj \(obj)")
                    }
                }
            }
            
            completed()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
    }

    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°C"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }


}

