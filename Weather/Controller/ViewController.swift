//
//  ViewController.swift
//  Weather
//
//  Created by Anastasiia ORJI on 9/11/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "cfb4888a8db82f14c9978548cc66696a"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //didUpdateLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                locationManager.delegate = nil
                
                let longitude = String(location.coordinate.longitude)
                let latitude = String(location.coordinate.latitude)
                
                print(longitude)
                print(latitude)
                
                let params : [String : String] = ["lat": latitude, "lon" : longitude, "appid" : APP_ID]
                
                getWeatherData(url: WEATHER_URL, parameters: params)
            }
        
    }
    
    //didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Got the weather")
                let weatherJSON : JSON  = JSON(response.result.value!)
//                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                self.cityLabel.text = "Connection Issues"
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    func updateWeatherData(json : JSON) {
        if let tempetature = json["main"]["temp"].double {
        weatherDataModel.temperature = Int(tempetature - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }
        
    }
    
    
    //MARK: - UI Updates (User Interface)
    /***************************************************************/
    func updateUIWithWeatherData(){
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    func newCityEntered(city: String) {
        cityLabel.text = city
        
        let params : [String : String] = ["q": city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.delegate = self
        }
    }

}

