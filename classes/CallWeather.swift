//
//  CallWeather.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 02/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
class CallWeather{
    
    var weather = WeatherStruct()
    
    
   

    //This is the one
    
    //#######################################################################
    func getWeatherStruct() -> WeatherStruct {
        
        var weatherstruct=WeatherStruct()
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Atlanta,us?&units=imperial&APPID=e03484e3ab6ace022b024d6b1aa41fd3")!
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Atlanta,us?&units=imperial&APPID=e03484e3ab6ace022b024d6b1aa41fd3") {
            
            var result=WeatherStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "weather") as? NSArray  {
                            var id = (mainDictionary[0] as AnyObject).value(forKeyPath: "id") as! Int64
                            var main = (mainDictionary[0] as AnyObject).value(forKeyPath: "main") as! String
                            var icon = (mainDictionary[0] as AnyObject).value(forKeyPath: "icon") as! String
                           var description = (mainDictionary[0] as AnyObject).value(forKeyPath: "description") as! String
                                
                                
                                
                                weatherstruct.id=String(id)
                                weatherstruct.main=String(main)
                                weatherstruct.icon=String(icon)
                                weatherstruct.description=String(description)
                                
                                print("THIS IS THE END",weatherstruct)
                                
                                
                                
                                
                            
                           
                        }
                        
                    }
//                    DispatchQueue.main.async {
//                        // self.tableView.reloadData()
//                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = weatherstruct //weather
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result
        }
        
        return weatherstruct
    }
    
    
    
    func getCurrentWeatherStruct(long: String, lat: String,unit: String) -> WeatherStruct {
       
        var AP=ConfigAP()
        var weatherstruct=WeatherStruct()
      
        if let url = URL(string: AP.weatherUrlbyLonandLat(unit: unit, lat_city: lat, long_city: long)) {
            
            var result=WeatherStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "weather") as? NSArray  {
                            var id = (mainDictionary[0] as AnyObject).value(forKeyPath: "id") as! Int64
                            var main = (mainDictionary[0] as AnyObject).value(forKeyPath: "main") as! String
                            var icon = (mainDictionary[0] as AnyObject).value(forKeyPath: "icon") as! String
                            var description = (mainDictionary[0] as AnyObject).value(forKeyPath: "description") as! String
                            
                            
                            
                            weatherstruct.id=String(id)
                            weatherstruct.main=String(main)
                            weatherstruct.icon=String(icon)
                            weatherstruct.description=String(description)
                            
                            print("THIS IS THE END",weatherstruct)
                            
                            
                            
                            
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        // self.tableView.reloadData()
                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = weatherstruct //weather
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result
        }
        
        return weatherstruct
    }
    
    
    func getWeatherStructByCity(city_name: String,city_country: String,unit: String) -> WeatherStruct {
        
        var AP=ConfigAP()
        var weatherstruct=WeatherStruct()
       
        if let url = URL(string: AP.weatherUrlbycity(unit: unit, city_name: city_name, city_country: city_country))
        {
            
            var result=WeatherStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
              
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "weather") as? NSArray  {
                            var id = (mainDictionary[0] as AnyObject).value(forKeyPath: "id") as! Int64
                            var main = (mainDictionary[0] as AnyObject).value(forKeyPath: "main") as! String
                            var icon = (mainDictionary[0] as AnyObject).value(forKeyPath: "icon") as! String
                            var description = (mainDictionary[0] as AnyObject).value(forKeyPath: "description") as! String
                            
                            
                            
                            weatherstruct.id=String(id)
                            weatherstruct.main=String(main)
                            weatherstruct.icon=String(icon)
                            weatherstruct.description=String(description)
                            
                            print("THIS IS THE END",weatherstruct)
                            
                            
                            
                            
                            
                           
                        }
                        
                    }
                    DispatchQueue.main.async {
                        // self.tableView.reloadData()
                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = weatherstruct //weather
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result
        }
        
        return weatherstruct
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getWeatherStructByID(id: String, unit: String) -> WeatherStruct {
        
        var weatherstruct=WeatherStruct()
        
        var AP=ConfigAP()

        if let url = URL(string: AP.weatherUrlbyID(unit: unit, id_city: id))
        {
            
            var result=WeatherStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
              
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "weather") as? NSArray  {
                            var id = (mainDictionary[0] as AnyObject).value(forKeyPath: "id") as! Int64
                            var main = (mainDictionary[0] as AnyObject).value(forKeyPath: "main") as! String
                            var icon = (mainDictionary[0] as AnyObject).value(forKeyPath: "icon") as! String
                            var description = (mainDictionary[0] as AnyObject).value(forKeyPath: "description") as! String
                            
                            
                            
                            weatherstruct.id=String(id)
                            weatherstruct.main=String(main)
                            weatherstruct.icon=String(icon)
                            weatherstruct.description=String(description)
                            
                            print("THIS IS THE END",weatherstruct)
                            
                            
                            
                            
                            
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        
                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = weatherstruct //or weathr
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result
        }
        
        return weatherstruct
    }
    
    
    
    
    
    
    

    
}
