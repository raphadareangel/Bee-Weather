//
//  SecondViewController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 04/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, CLLocationManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    var unit: String="imperial"
    var lg = String ()
    var lat = String()
    var locationManager = CLLocationManager()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var forecastSend:[ForeCastStruct]?=[]
    var foreCastList:[[ForeCastStruct]]?=[]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
           // startActivityIndicator()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
           // stopActivityIndicator()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                if(self.lat != "" && self.lg != ""){
                    
                
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                
                
                var currentController=CurrentController()
                foreCastList=currentController.forecastCurrentLocationByDays(long: self.lg, lat: self.lat,unit:unit)
                print(foreCastList![0][0].country)
                
                
                self.collectionView.reloadData()
                
                }
                
                
                
                
            }
        } else {
            print("Location services are not enabled")
        }
        
        
      
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NSLog("viewDidAppear is running")
        LocationVerifyMessage(titleText : "Location Services", messageText : "Your have to give acces to your location in order to use this functions")
        
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                var currentController=CurrentController()
                foreCastList=currentController.forecastCurrentLocationByDays(long: String(lg), lat: String(lat),unit:unit)
                self.collectionView.reloadData()
                
            }
        } else {
            print("Location services are not enabled")
        }
        
        
       
    }

// I was planing to track the users but expends a lot of batery I decided to remove this
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        startActivityIndicator()
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        self.lg=String(locValue.longitude)
//        self.lat=String(locValue.latitude)
//        let userLocation = locations.last
//
//        var currentController=CurrentController()
//        foreCastList=currentController.forecastCurrentLocationByDays(long: String(locValue.longitude), lat: String(locValue.latitude),unit:unit)
//        print(foreCastList![0][0].country)
//
////        var day2=foreCastList[1][0].country
////        var day3=foreCastList[2]
////        var day4=foreCastList[3]
////        var day5=foreCastList[4]
//
//
////        var integ=0
////        var contries=foreCastList![integ][0].country
////        var cities=foreCastList![integ][0].name
////        var population=foreCastList![integ][0].temperature
////        var date_day=foreCastList![integ][0].dtx
////        var temp_max=foreCastList![integ][0].temperature_max
////        var temp_min=foreCastList![integ][0].temperature_min
////        var weather=foreCastList![integ][0].weather_description
////        var weather_main=foreCastList![integ][0].weather_main
////
//
//
//
//
//        self.collectionView.reloadData()
//
//        stopActivityIndicator()
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (foreCastList?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var datechange=DateDeals()
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        
        
        
        
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        
        
        
        
        
        let country = cell.viewWithTag(1) as! UILabel
        let city = cell.viewWithTag(2) as! UILabel
        let temperature = cell.viewWithTag(3) as! UILabel
        let weather = cell.viewWithTag(7) as! UILabel
        let date = cell.viewWithTag(8) as! UILabel
        
        let temp_max = cell.viewWithTag(4) as! UILabel
        let temp_min = cell.viewWithTag(5) as! UILabel
        let pressure = cell.viewWithTag(6) as! UILabel
        let population = cell.viewWithTag(9) as! UILabel
        
        temp_max.text=foreCastList?[indexPath.row][0].temperature_max
        temp_min.text=foreCastList?[indexPath.row][0].temperature_min
        pressure.text=foreCastList?[indexPath.row][0].pressure
        population.text=foreCastList?[indexPath.row][0].population

        country.text=foreCastList?[indexPath.row][0].country
        city.text=foreCastList?[indexPath.row][0].name
        temperature.text=foreCastList?[indexPath.row][0].temperature
        weather.text=foreCastList?[indexPath.row][0].weather_description
        date.text=datechange.dateToCompare(dateString:  (foreCastList?[indexPath.row][0].dtx)!)
        
        
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ForeCastDayController{

            
            var send=self.forecastSend


            destination.foreCastDaysList = send
        }
    
    
}
    
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

         self.forecastSend = self.foreCastList![indexPath.row]
    
     performSegue(withIdentifier: "forecasday", sender: self)

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
