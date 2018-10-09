//
//  ForeCastDayController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 05/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ForeCastDayController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var foreCastList:[[ForeCastStruct]]?=[]
    var foreCastDaysList:[ForeCastStruct]?=[]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (foreCastDaysList?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        startActivityIndicator()
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
        
        country.text=foreCastDaysList?[indexPath.row].country
        city.text=foreCastDaysList?[indexPath.row].name
        temperature.text=foreCastDaysList?[indexPath.row].temperature
        weather.text=foreCastDaysList?[indexPath.row].weather_description
        //date.text=foreCastDaysList?[indexPath.row].dtx
        date.text=datechange.dateTohour(dateString:  (foreCastDaysList?[indexPath.row].dtx)!)
        let temp_max = cell.viewWithTag(4) as! UILabel
        let temp_min = cell.viewWithTag(5) as! UILabel
        let pressure = cell.viewWithTag(6) as! UILabel
        let population = cell.viewWithTag(9) as! UILabel
        
        temp_max.text=foreCastDaysList?[indexPath.row].temperature_max
        temp_min.text=foreCastDaysList?[indexPath.row].temperature_min
        pressure.text=foreCastDaysList?[indexPath.row].pressure
        population.text=foreCastDaysList?[indexPath.row].population
        stopActivityIndicator()
        return cell
        
    }
    
    func startActivityIndicator()
    {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator()
    {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

