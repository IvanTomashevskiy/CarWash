//
//  MainViewController.swift
//  CarWash
//
//  Created by Иван on 15.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController{
    
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var wetherIconImg: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
        
    override func viewDidLoad() {
            super.viewDidLoad()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
    
            weatherManager.delegate = self
            searchField.delegate = self
        }
    
}
    // MARK: - UITextFieldDelegate
    extension MainViewController: UITextFieldDelegate {
        @IBAction func searchPressed(_ sender: UIButton) {
            searchField.endEditing(true)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            guard let city = textField.text else { return }
            weatherManager.fetchWeater(sityName: city)
            textField.text = ""
        }
    }

  // MARK: - WeatherDelegate
   extension MainViewController: WeatherDelegate {
   func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            DispatchQueue.main.async {
                self.tempLbl.text = "\(weather.temperatureString)ºC"
                self.wetherIconImg.image = UIImage(systemName: weather.conditionName)
                self.cityLbl.text = "Ваш город \(weather.cityName)"
            }
        }
    }

    // MARK: - CLLocationManagerDelegate
    extension MainViewController: CLLocationManagerDelegate {
        @IBAction func showLocation(_ sender: UIButton) {
            locationManager.requestLocation()
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            locationManager.stopUpdatingLocation()

            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            weatherManager.fetchWeater(lan: lat, lon: lon)
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }

}

    

