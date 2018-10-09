//
//  ForecastDayFoundViewController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 06/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit


class ForecastDayFoundViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    
    
    var forecastSend:[ForeCastStruct]?=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (forecastSend?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //startActivityIndicator()
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
        
        var idCountryController=IDCountryController()
        //foreCastDaysList=idCountryController.forecastCurrentLocation(cityID: self.cityID)
        
        
        
        let country = cell.viewWithTag(1) as! UILabel
        let city = cell.viewWithTag(2) as! UILabel
        let temperature = cell.viewWithTag(3) as! UILabel
        let weather = cell.viewWithTag(7) as! UILabel
        let date = cell.viewWithTag(8) as! UILabel
        
        country.text=forecastSend?[indexPath.row].country
        city.text=forecastSend?[indexPath.row].name
        temperature.text=forecastSend?[indexPath.row].temperature
        weather.text=forecastSend?[indexPath.row].weather_description
        //date.text=forecastSend?[indexPath.row].dtx
        date.text=datechange.dateTohour(dateString:  (forecastSend?[indexPath.row].dtx)!)
        var citys=forecastSend?[indexPath.row]

        
        let temp_max = cell.viewWithTag(4) as! UILabel
        let temp_min = cell.viewWithTag(5) as! UILabel
        let pressure = cell.viewWithTag(6) as! UILabel
        let population = cell.viewWithTag(9) as! UILabel
        
        temp_max.text=forecastSend?[indexPath.row].temperature_max
        temp_min.text=forecastSend?[indexPath.row].temperature_min
        pressure.text=forecastSend?[indexPath.row].pressure
        population.text=forecastSend?[indexPath.row].population
        
        return cell
        
    }
}
