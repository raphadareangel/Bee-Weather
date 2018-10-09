//
//  SelectedCityForecastViewController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 06/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit

class SelectedCityForecastViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    var unit: String="imperial"
    var city=CityStruct()
    var forecastSend:[ForeCastStruct]?=[]
    var foreCastList:[[ForeCastStruct]]?=[]
    
    @IBOutlet weak var selectedCityForeCastCollectionView: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("THIS IS THE CITY",city)
        // Do any additional setup after loading the view, typically from a nib.
        

        
        self.selectedCityForeCastCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        
        loadFiveDays()
        
    }
    
    
    func loadFiveDays() {
       // startActivityIndicator()
       
        
        var nameCountryController=NameCountryController()
        foreCastList=nameCountryController.forecastBycity(city_name: city.name, city_country: city.country,unit:unit)
   
        
        
        
        
        self.selectedCityForeCastCollectionView.reloadData()
        
        //stopActivityIndicator()
        
    }
    
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
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        
        
        let country = cell.viewWithTag(1) as! UILabel
        let city = cell.viewWithTag(2) as! UILabel
        let temperature = cell.viewWithTag(3) as! UILabel
        let weather = cell.viewWithTag(7) as! UILabel
        let date = cell.viewWithTag(8) as! UILabel
        
        country.text=foreCastList?[indexPath.row][0].country
        city.text=foreCastList?[indexPath.row][0].name
        temperature.text=foreCastList?[indexPath.row][0].temperature
        weather.text=foreCastList?[indexPath.row][0].weather_description
        date.text=datechange.dateToCompare(dateString:  (foreCastList?[indexPath.row][0].dtx)!)
        
        let temp_max = cell.viewWithTag(4) as! UILabel
        let temp_min = cell.viewWithTag(5) as! UILabel
        let pressure = cell.viewWithTag(6) as! UILabel
        let population = cell.viewWithTag(9) as! UILabel
        
        temp_max.text=foreCastList?[indexPath.row][0].temperature_max
        temp_min.text=foreCastList?[indexPath.row][0].temperature_min
        pressure.text=foreCastList?[indexPath.row][0].pressure
        population.text=foreCastList?[indexPath.row][0].population
        return cell
    }
    
    
    
    
    
    
    // if in the future i decided to add this view
    //performSegue(withIdentifier: "forecastDayFoundView", sender: self)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ForecastDayFoundViewController{
            
            
            var send=self.forecastSend
            
            
            destination.forecastSend = send
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // I finaly decided to add this view
        self.forecastSend = self.foreCastList![indexPath.row]
        
        
        performSegue(withIdentifier: "forecastDayFoundView", sender: self)
        
    }
}
