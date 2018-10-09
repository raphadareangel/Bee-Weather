//
//  SelectedCityViewController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 05/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation

import UIKit

class SelectedCityViewController: UIViewController  {
    var unit: String="imperial"
    var city=CityStruct()
    
    @IBOutlet weak var selectedCityCountry: UILabel!
    
    @IBOutlet weak var selectedCityCity: UILabel!
    
    @IBOutlet weak var selectedCityTemperatura: UILabel!
    
    @IBOutlet weak var selectedCityTempMax: UILabel!
    
    @IBOutlet weak var selectedCityTempMin: UILabel!
    
    @IBOutlet weak var selectedCityPressure: UILabel!
    
    @IBOutlet weak var selectedCityHumidity: UILabel!
    
    @IBOutlet weak var selectedCityWeatherDescription: UILabel!
    
    @IBOutlet weak var imageWeather: UIImageView!
    
    
    @IBOutlet weak var changeButton: UIButton!
    
    
    @IBAction func changeUnit(_ sender: Any) {
        
        if(changeButton.currentTitle=="Imperial"){
            changeButton.setTitle("Metric", for: .normal)
            unit="metric"
            
            var nameCountryController=NameCountryController()
            var mainS=nameCountryController.mainByCity(city_name: city.name, city_country: city.country,unit:unit)
            var weatherS=nameCountryController.weatherByCity(city_name: city.name, city_country: city.country,unit:unit)
            
            
            selectedCityCountry.text=mainS.country
            selectedCityCity.text=mainS.main_city
            selectedCityTemperatura.text=mainS.temp
            selectedCityTempMax.text=mainS.temp_max
            selectedCityTempMin.text=mainS.temp_min
            selectedCityPressure.text=mainS.pressure
            selectedCityHumidity.text=mainS.humidity
            selectedCityWeatherDescription.text=weatherS.description
            
            
                var AP=ConfigAP()
                let format=".png"
                let weather_icon=AP.icon_url+(weatherS.icon)+format
                let weatherURL = URL(string:weather_icon )!
                self.imageWeather.image=UIImage(url: weatherURL)
                
                
                
           
           
            
        }else if(changeButton.currentTitle=="Metric"){
            changeButton.setTitle("Imperial", for: .normal)
            unit="imperial"
            
            var nameCountryController=NameCountryController()
            var mainS=nameCountryController.mainByCity(city_name: city.name, city_country: city.country,unit:unit)
            var weatherS=nameCountryController.weatherByCity(city_name: city.name, city_country: city.country,unit:unit)
            
            
            selectedCityCountry.text=mainS.country
            selectedCityCity.text=mainS.main_city
            selectedCityTemperatura.text=mainS.temp
            selectedCityTempMax.text=mainS.temp_max
            selectedCityTempMin.text=mainS.temp_min
            selectedCityPressure.text=mainS.pressure
            selectedCityHumidity.text=mainS.humidity
            selectedCityWeatherDescription.text=weatherS.description
            
            
            
                var AP=ConfigAP()
                let format=".png"
                let weather_icon=AP.icon_url+(weatherS.icon)+format
                let weatherURL = URL(string:weather_icon )!
                self.imageWeather.image=UIImage(url: weatherURL)
                
                
            
            
        }
        
    }
    
    
    
    
    
    
    @IBAction func SelectedCityViewForeCastB(_ sender: UIButton) {
        performSegue(withIdentifier: "selectedCityForecastViewList", sender: self)
    }
    
    @IBAction func SelectedCityAddCity(_ sender: UIButton) {
        createAlert(titleText: "Add city", messageText: " Was Successfuly Added", cityName: self.city.name)
        tabBarController?.tabBar.items?[2].badgeValue = "New"
        tabBarController?.tabBar.items?[2].badgeColor=UIColor.darkGray
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        print("THIS IS THE CITY",city)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var nameCountryController=NameCountryController()
        var mainS=nameCountryController.mainByCity(city_name: city.name, city_country: city.country,unit:unit)
        var weatherS=nameCountryController.weatherByCity(city_name: city.name, city_country: city.country,unit:unit)
        

        selectedCityCountry.text=mainS.country
        selectedCityCity.text=mainS.main_city
        selectedCityTemperatura.text=mainS.temp
        selectedCityTempMax.text=mainS.temp_max
        selectedCityTempMin.text=mainS.temp_min
        selectedCityPressure.text=mainS.pressure
        selectedCityHumidity.text=mainS.humidity
        selectedCityWeatherDescription.text=weatherS.description
//        stopActivityIndicator()
        
        
            var AP=ConfigAP()
            let format=".png"
            let weather_icon=AP.icon_url+(weatherS.icon)+format
            let weatherURL = URL(string:weather_icon )!
            self.imageWeather.image=UIImage(url: weatherURL)
            
            
            
       
       
    }
    
    
    func createAlert(titleText : String, messageText : String, cityName :String){
        CoreDataManager.storeObj(id :self.city.id,
                                 country: self.city.country,
                                 name:self.city.name,
                                 population:self.city.population)
        let alert = UIAlertController(title: titleText, message: cityName+messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? SelectedCityForecastViewController{
        
        destination.city = self.city
        destination.unit=self.unit
    }
}
    
    
    
    
    
    
}
