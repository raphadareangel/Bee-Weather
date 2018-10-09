//
//  LocalPanelWeatherController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 06/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit

class LocalPanelWeatherController: UIViewController {
    var city=CityStruct()
    var cityID = String ()
    var cityCountry = String()
    var cityName = String()
    var unit: String="imperial"
    @IBOutlet weak var selectedLocalCityCountry: UILabel!
    @IBOutlet weak var selectedLocalCityCity: UILabel!
    @IBOutlet weak var selectedLocalCityTemperature: UILabel!
    @IBOutlet weak var selectedLocalCityTempMax: UILabel!
    @IBOutlet weak var selectedLocalCityTempMin: UILabel!
    @IBOutlet weak var selectedLocalCityPressure: UILabel!
    @IBOutlet weak var selectedLocalCityHumidity: UILabel!
    @IBOutlet weak var selectedLocalCityWeatherDescription: UILabel!
    
    @IBOutlet weak var imageWeather: UIImageView!
    
    @IBOutlet weak var ChangeButton: UIButton!
    
    @IBAction func ViewForecastSumary(_ sender: Any) {
    
    performSegue(withIdentifier: "localforecastsumary", sender: self)
    
    }
    
    
    @IBAction func DeleteLocalCity(_ sender: Any) {
        
        
       CoreDataManager.deletecityCoreData(CityID: cityID)
        createAlert(titleText: "Deleted cicity", messageText: " was deleted from your list", cityName: self.cityName)

    }
    
    
    @IBAction func changeUnit(_ sender: Any) {
        
        if(ChangeButton.currentTitle=="Imperial"){
            ChangeButton.setTitle("Metric", for: .normal)
            unit="metric"
            
            
            
            
            var idCountryController=IDCountryController()
            var mainS=idCountryController.mainByID(cityID: cityID, unit: unit)
            var weatherS=idCountryController.weatherByID(cityID: cityID, unit: unit)
            
            
            
            selectedLocalCityCountry.text=mainS.country
            selectedLocalCityCity.text=mainS.main_city
            selectedLocalCityTemperature.text=mainS.temp
            selectedLocalCityTempMax.text=mainS.temp_max
            selectedLocalCityTempMin.text=mainS.temp_min
            selectedLocalCityPressure.text=mainS.pressure
            selectedLocalCityHumidity.text=mainS.humidity
            selectedLocalCityWeatherDescription.text=weatherS.description
            
            
                var AP=ConfigAP()
                let format=".png"
                let weather_icon=AP.icon_url+(weatherS.icon)+format
                let weatherURL = URL(string:weather_icon )!
                self.imageWeather.image=UIImage(url: weatherURL)
                
                
                
            
            
        }else if(ChangeButton.currentTitle=="Metric"){
            ChangeButton.setTitle("Imperial", for: .normal)
            unit="imperial"
            
            var idCountryController=IDCountryController()
            var mainS=idCountryController.mainByID(cityID: cityID, unit: unit)
            var weatherS=idCountryController.weatherByID(cityID: cityID, unit: unit)
            
            
            
            selectedLocalCityCountry.text=mainS.country
            selectedLocalCityCity.text=mainS.main_city
            selectedLocalCityTemperature.text=mainS.temp
            selectedLocalCityTempMax.text=mainS.temp_max
            selectedLocalCityTempMin.text=mainS.temp_min
            selectedLocalCityPressure.text=mainS.pressure
            selectedLocalCityHumidity.text=mainS.humidity
            selectedLocalCityWeatherDescription.text=weatherS.description
            
            
            
                var AP=ConfigAP()
                let format=".png"
                let weather_icon=AP.icon_url+(weatherS.icon)+format
                let weatherURL = URL(string:weather_icon )!
                self.imageWeather.image=UIImage(url: weatherURL)
                
                
                
            
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        print("THIS IS THE CITY ID",cityID)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var idCountryController=IDCountryController()
        var mainS=idCountryController.mainByID(cityID: cityID, unit: unit)
        var weatherS=idCountryController.weatherByID(cityID: cityID, unit: unit)
        
        
        
        selectedLocalCityCountry.text=mainS.country
        selectedLocalCityCity.text=mainS.main_city
        selectedLocalCityTemperature.text=mainS.temp
        selectedLocalCityTempMax.text=mainS.temp_max
        selectedLocalCityTempMin.text=mainS.temp_min
        selectedLocalCityPressure.text=mainS.pressure
        selectedLocalCityHumidity.text=mainS.humidity
        selectedLocalCityWeatherDescription.text=weatherS.description
        
        self.cityCountry = mainS.country
        self.cityName = mainS.main_city
        
        
            var AP=ConfigAP()
            let format=".png"
            let weather_icon=AP.icon_url+(weatherS.icon)+format
            let weatherURL = URL(string:weather_icon )!
            self.imageWeather.image=UIImage(url: weatherURL)
            
            
            
       
        //        stopActivityIndicator()
        
    }
    
    
    func createAlert(titleText : String, messageText : String, cityName :String){
       
        let alert = UIAlertController(title: titleText, message: cityName+messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalCityForecastSumaryViewController{
            
            destination.cityID = cityID
            destination.cityCountry=cityCountry
            destination.cityName=cityName
            destination.unit=unit
        }
    }
    
  
    
    
}
