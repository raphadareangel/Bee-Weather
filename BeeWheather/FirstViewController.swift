//
//  FirstViewController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 04/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import UIKit
import MapKit


class FirstViewController: UIViewController,CLLocationManagerDelegate  {
    var locationManager = CLLocationManager()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var unit: String="imperial"
    var lg = String ()
    var lat = String()
    @IBOutlet weak var currentCountry: UILabel!
    @IBOutlet weak var currentCity: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentMaxTemperature: UILabel!
    @IBOutlet weak var currentMinTemperature: UILabel!
    @IBOutlet weak var currentPressure: UILabel!
    @IBOutlet weak var currentHumidyty: UILabel!
    @IBOutlet weak var currentWeatherDescription: UILabel!
    
    @IBOutlet weak var buttonChanche: UIButton!
    
   
    @IBOutlet weak var imageWeather: UIImageView!
    
    
    
    //refactor this method
    
    @IBAction func changeUnit(_ sender: Any) {
        if(buttonChanche.currentTitle=="Imperial"){
            buttonChanche.setTitle("Metric", for: .normal)
            unit="metric"
            
            var currentController=CurrentController()
            var mainS=currentController.mainCurrentLocation(long: String(lg), lat: String(lat),unit:unit)
            var weatherS=currentController.weatherCurrentLocation(long: String(lg), lat: String(lat),unit:unit)
            
            
            
            currentCountry.text=mainS.country
            currentCity.text=mainS.main_city
            currentTemperature.text=mainS.temp
            currentMaxTemperature.text=mainS.temp_max
            currentMinTemperature.text=mainS.temp_min
            currentPressure.text=mainS.pressure
            currentHumidyty.text=mainS.humidity
            currentWeatherDescription.text=weatherS.description
            DispatchQueue.main.async {
                var AP=ConfigAP()
                let format=".png"
                let weather_icon=AP.icon_url+(weatherS.icon)+format
                let weatherURL = URL(string:weather_icon )!
                self.imageWeather.image=UIImage(url: weatherURL)
                
                
                
            }
            if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController{
                if let testController = navController.children.first as? SecondViewController{
                    testController.unit = unit
                    //self.tabBarController?.selectedIndex = 1
                }
                
            }
            
        }else if(buttonChanche.currentTitle=="Metric"){
            buttonChanche.setTitle("Imperial", for: .normal)
            unit="imperial"
            
            var currentController=CurrentController()
            var mainS=currentController.mainCurrentLocation(long: String(lg), lat: String(lat),unit:unit)
            var weatherS=currentController.weatherCurrentLocation(long: String(lg), lat: String(lat),unit:unit)
            
            
            
            currentCountry.text=mainS.country
            currentCity.text=mainS.main_city
            currentTemperature.text=mainS.temp
            currentMaxTemperature.text=mainS.temp_max
            currentMinTemperature.text=mainS.temp_min
            currentPressure.text=mainS.pressure
            currentHumidyty.text=mainS.humidity
            currentWeatherDescription.text=weatherS.description
            
                var AP=ConfigAP()
                let format=".png"
                let weather_icon=AP.icon_url+(weatherS.icon)+format
                let weatherURL = URL(string:weather_icon )!
                self.imageWeather.image=UIImage(url: weatherURL)
                
                
                
            
            
            if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController{
                if let testController = navController.children.first as? SecondViewController{
                    testController.unit = unit
                    
                }
            }
            
        }
        
    }
    
    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        self.locationManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //startActivityIndicator()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            //stopActivityIndicator()
        }
            
        

        
        
       
        
    }// end of did load
    
    
    override func viewDidAppear(_ animated: Bool) {
        

       // startActivityIndicator()
        
        super.viewDidAppear(true)
        NSLog("viewDidAppear is running")
        LocationVerifyMessage(titleText : "Location Services", messageText : "Your have to give acces to your location in order to use this functions")
        
        
        
       
        
    }

    
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // startActivityIndicator()
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        self.lg=String(locValue.longitude)
        self.lat=String(locValue.latitude)
        var currentController=CurrentController()
        var mainS=currentController.mainCurrentLocation(long: String(locValue.longitude), lat: String(locValue.latitude),unit:unit)
        var weatherS=currentController.weatherCurrentLocation(long: String(locValue.longitude), lat: String(locValue.latitude),unit:unit)


            var AP=ConfigAP()
            let format=".png"
            let weather_icon=AP.icon_url+(weatherS.icon)+format
            let weatherURL = URL(string:weather_icon )!
            self.imageWeather.image=UIImage(url: weatherURL)


        if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController{
            if let testController = navController.children.first as? SecondViewController{
                testController.lg = lg
                testController.lat = lat
                
            }
        }


        currentCountry.text=mainS.country
        currentCity.text=mainS.main_city
        currentTemperature.text=mainS.temp
        currentMaxTemperature.text=mainS.temp_max
        currentMinTemperature.text=mainS.temp_min
        currentPressure.text=mainS.pressure
        currentHumidyty.text=mainS.humidity
        currentWeatherDescription.text=weatherS.description
        
        
        if(self.lat != "" && self.lg != ""){
            locationManager.stopUpdatingLocation()
            stopActivityIndicator()
        }


    }

// future use
    func renderViewValues()  {
        var currentController=CurrentController()
        var mainS=currentController.mainCurrentLocation(long: self.lg, lat: self.lat,unit:unit)
        var weatherS=currentController.weatherCurrentLocation(long: self.lg, lat: self.lat,unit:unit)
        currentCountry.text=mainS.country
        currentCity.text=mainS.main_city
        currentTemperature.text=mainS.temp
        currentMaxTemperature.text=mainS.temp_max
        currentMinTemperature.text=mainS.temp_min
        currentPressure.text=mainS.pressure
        currentHumidyty.text=mainS.humidity
        currentWeatherDescription.text=weatherS.description
        DispatchQueue.main.async {
            var AP=ConfigAP()
            let format=".png"
            let weather_icon=AP.icon_url+(weatherS.icon)+format
            let weatherURL = URL(string:weather_icon )!
            self.imageWeather.image=UIImage(url: weatherURL)
            
            
            
        }
        
        if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController{
            if let testController = navController.children.first as? SecondViewController{
                testController.unit = unit
                
            }
        }
    }
    
    
    
    func startActivityIndicator()
    {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        UIApplication.shared.beginIgnoringInteractionEvents()
       
        view.addSubview(activityIndicator)
        
        
        activityIndicator.startAnimating()
       
    }
    
    func stopActivityIndicator()
    {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
 
    
    func LocationVerifyMessage(titleText : String, messageText : String){

        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)

        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (_) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(settingsAction)
        // check the permission status
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorize.")
        // get the user location
        case .notDetermined, .restricted, .denied:
            // redirect the users to settings
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
      
}

