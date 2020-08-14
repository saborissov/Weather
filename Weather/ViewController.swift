//
//  ViewController.swift
//  Weather
//
//  Created by 17586317 on 30.06.2020.
//  Copyright © 2020 Борисов Сергей Александрович. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var vlagnostLabel: UILabel!
    @IBOutlet weak var davlenieLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    
    let locationManager = CLLocationManager()
    //свойство для получения json
    var weatherData = WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocationManager()
    }

    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateView()  {
        cityNameLabel.text = weatherData.name
        temperatureLabel.text = weatherData.main.temp.description + "º"
        weatherDescriptionLabel.text = weatherData.weather[0].description
        iconImageView.image = UIImage(named: weatherData.weather[0].icon)
        vlagnostLabel.text = weatherData.main.humidity.description + "%"
        davlenieLabel.text = weatherData.main.pressure.description
        feelingLabel.text = weatherData.main.feels_like.description
    }
    
    func updateWeatherInfo(latitude:Double, longtitude:Double) {
        let session = URLSession.shared
        let url  = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&units=metric&lang=ru&appid=973ae162a7331dec9c48f1d319cac64e")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }
            
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                DispatchQueue.main.async {
                    self.updateView()
                }
                print(self.weatherData)
                
                
            } catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

}

extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last{
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}
