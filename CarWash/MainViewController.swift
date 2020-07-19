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
    
    @IBOutlet weak var mainLbl: UILabel!
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
    func addBoldText(fullString: NSString, boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
    let normalFont = UIFont(name: "Dosis-Medium", size: 18)
    let boldSearchFont = UIFont(name: "Dosis-Bold", size: 18)
    
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


extension String {
    func withBoldText(boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}



  // MARK: - WeatherDelegate
   extension MainViewController: WeatherDelegate {
   func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            DispatchQueue.main.async {
                self.tempLbl.text = "\(weather.temperatureString)ºC"
                self.wetherIconImg.image = UIImage(systemName: weather.conditionName)
                self.cityLbl.text = "Ваш город \(weather.cityName)"
                let font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.regular)
                let boldFont = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
                self.mainLbl.attributedText = weather.conditionMain.withBoldText(
                    boldPartsOfString: ["мы не советуем вам мыть машину.", "мы советуем вам мыть машину."], font: font, boldFont: boldFont)
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

    

