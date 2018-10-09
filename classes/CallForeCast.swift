//
//  File.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 02/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
class CallForeCast{
    
    var weather = MainStruct()
    var forecasts:[ForeCastStruct]?=[]
    

    
    //This is the one
    // I need to refactor after demo to show handle data types
    func getForeCastList() -> [ForeCastStruct] {
        
        var weatherstruct=WeatherStruct()
        var forecast = ForeCastStruct()
       var city = CityStruct()
        var result:[ForeCastStruct]?=[]
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Atlanta,us?&units=imperial&APPID=e03484e3ab6ace022b024d6b1aa41fd3") {
            
            
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "city") as? NSDictionary  {
                            if let id  = mainDictionary.value(forKey: "id") as? Int,
                                let name  = mainDictionary.value(forKey: "name") as? String,
                                let country  = mainDictionary.value(forKey: "country") as? String
                            {
                                if let population  = mainDictionary.value(forKey: "population") as? Int{
                                    city.population=String(population)
                                }
                                city.id=String(id)
                                city.name=String(name)
                                city.country=String(country)
                               

                                
                                

                                print("THIS IS THE END",city )
                                
                                
                                
                                
                           }
                            
                            
                           
                        }
                        
                        
                        if let mainArray = jsonObj!.value(forKey: "list") as? NSArray  {

                            
                            
                            
                            
                            
                            
                            for resultFromJson in mainArray {

                                forecast.id=city.id
                                forecast.name = city.name
                                forecast.country = city.country
                                forecast.population = city.population
                                
                                
                                if let arrayDictionary = resultFromJson as? NSDictionary  {
                                    // date
                                    if let dt_txt = arrayDictionary.value(forKey: "dt_txt") as? String{
                                        
                                        forecast.dtx=String(dt_txt)
                                        print(dt_txt)
                                    }
                                
                                    if let main = arrayDictionary.value(forKey: "main") as? NSDictionary  {
                                         if let temperature  = main.value(forKey: "temp") as? Double,
                                            let temperature_max  = main.value(forKey: "temp_max") as? Double,
                                            let temperature_min  = main.value(forKey: "temp_min") as? Double,
                                            let pressure  = main.value(forKey: "pressure") as? Double,
                                            let humidity  = main.value(forKey: "humidity") as? Int{
                                            
                                            
                                            forecast.temperature=String(temperature)
                                            forecast.temperature_max=String(temperature_max)
                                            forecast.temperature_min=String(temperature_min)
                                            forecast.pressure=String(pressure)
                                            forecast.humidity=String(humidity)
                                            
                                            print(temperature)
                                        }
                                    }
                                    
                                    if let weather=arrayDictionary.value(forKey: "weather") as? NSArray  {
                                    
                                                                  var weather_id = (weather[0] as AnyObject).value(forKeyPath: "id") as! Int64
                                                                    var weather_main = (weather[0] as AnyObject).value(forKeyPath: "main") as! String
                                                                    var icon = (weather[0] as AnyObject).value(forKeyPath: "icon") as! String
                                                                    var weather_description = (weather[0] as AnyObject).value(forKeyPath: "description") as! String
                                        
                                        forecast.weather_id=String(weather_id)
                                        forecast.weather_main=String(weather_main)
                                        forecast.icon=String(icon)
                                        forecast.weather_description=String(weather_description)
                                        
                                        print(weather_description)
                                        
                                    }
                                }
                                
                                 self.forecasts?.append(forecast)
                               
                            }
                       
                        
                        }
                        
                        
                        
                        
                    }
                    DispatchQueue.main.async {
                        result = self.forecasts
                        
                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                result = self.forecasts //or false in case
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result!
        }
        
        return result!
    }
    
    
    
    
    
    
    
    func getCurrentForeCastList(long: String, lat: String,unit: String) -> [ForeCastStruct] {
        var imperial:String="imperial"
        var AP=ConfigAP()
        var weatherstruct=WeatherStruct()
        var currentValues="lat=\(lat)&lon=\(long)"
        var forecast = ForeCastStruct()
        var city = CityStruct()
        var result:[ForeCastStruct]?=[]
        if let url = URL(string: AP.forecastUrlbyLonandLat(unit: unit, lat_city: lat, long_city: long)) {
            
            
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
            
                do{
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "city") as? NSDictionary  {
                            if let id  = mainDictionary.value(forKey: "id") as? Int,
                                let name  = mainDictionary.value(forKey: "name") as? String,
                                let country  = mainDictionary.value(forKey: "country") as? String
                            {
                                if let population  = mainDictionary.value(forKey: "population") as? Int{
                                    city.population=String(population)
                                }
                                
                                city.id=String(id)
                                city.name=String(name)
                                city.country=String(country)
                                
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                        if let mainArray = jsonObj!.value(forKey: "list") as? NSArray  {
                            
                            
                            
                            
                            
                            
                            for resultFromJson in mainArray {
                                
                                forecast.id=city.id
                                forecast.name = city.name
                                forecast.country = city.country
                                forecast.population = city.population
                                
                                
                                if let arrayDictionary = resultFromJson as? NSDictionary  {
                                    // date
                                    if let dt_txt = arrayDictionary.value(forKey: "dt_txt") as? String{
                                        
                                        forecast.dtx=String(dt_txt)
                                        //print(dt_txt)
                                    }
                                    
                                    if let main = arrayDictionary.value(forKey: "main") as? NSDictionary  {
                                        if let humidity = main.value(forKey: "humidity")as? Int64{
                                            forecast.humidity=String(humidity)
                                            
                                        }
                                        if let pressure = main.value(forKey: "pressure") as? Int64{
                                            forecast.pressure=String(pressure)
                                            
                                        }
                                        if let temp_max = main.value(forKey: "temp_max") as? Double{
                                            forecast.temperature_max = String(temp_max)
                                            
                                        }
                                        if let temp_min = main.value(forKey: "temp_min") as? Double{
                                            forecast.temperature_min=String(temp_min)
                                            
                                        }
                                        if let temperature  = main.value(forKey: "temp") as? Double  {
                                            
                                            
                                            
                                            forecast.temperature=String(temperature)
                                            
                                            
                                            
                                            
                                            print("THIS IS THE END",forecast)
                                            
                                            
                                            
                                            
                                        }
                                    }
                                    
                                    if let weather=arrayDictionary.value(forKey: "weather") as? NSArray  {
                                        
                                        var weather_id = (weather[0] as AnyObject).value(forKeyPath: "id") as! Int64
                                        var weather_main = (weather[0] as AnyObject).value(forKeyPath: "main") as! String
                                        var icon = (weather[0] as AnyObject).value(forKeyPath: "icon") as! String
                                        var weather_description = (weather[0] as AnyObject).value(forKeyPath: "description") as! String
                                        
                                        forecast.weather_id=String(weather_id)
                                        forecast.weather_main=String(weather_main)
                                        forecast.icon=String(icon)
                                        forecast.weather_description=String(weather_description)
                                        
                                       
                                        
                                    }
                                }
                                
                                self.forecasts?.append(forecast)
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
//                    DispatchQueue.main.async {
//                        result = self.forecasts
//                        // self.tableView.reloadData()
//                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                result = self.forecasts //or false in case
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result!
        }
        
        return result!
    }
    
    
    func getForeCastListByCity(city_name: String, city_country: String, unit: String) -> [ForeCastStruct] {
        var imperial:String="imperial"
        var AP=ConfigAP()
        var weatherstruct=WeatherStruct()
       
        var forecast = ForeCastStruct()
        var city = CityStruct()
        var result:[ForeCastStruct]?=[]

        if let url = URL(string: AP.forecastUrlbycity(unit: unit, city_name: city_name, city_country: city_country))
        {
        
            
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "city") as? NSDictionary  {
                            if let id  = mainDictionary.value(forKey: "id") as? Int,
                                let name  = mainDictionary.value(forKey: "name") as? String,
                                let country  = mainDictionary.value(forKey: "country") as? String
                            {
                                if let population  = mainDictionary.value(forKey: "population") as? Int{
                                    city.population=String(population)
                                }
                                city.id=String(id)
                                city.name=String(name)
                                city.country=String(country)
                                
                                
                                
                                
                                
                                //print("THIS IS THE END",city )
                                
                                
                                
                                
                            }
                            
                            
                           
                        }
                        
                        
                        if let mainArray = jsonObj!.value(forKey: "list") as? NSArray  {
                            
                            
             
                            
                            
                            
                            for resultFromJson in mainArray {
                                
                                forecast.id=city.id
                                forecast.name = city.name
                                forecast.country = city.country
                                forecast.population = city.population
                                
                                
                                if let arrayDictionary = resultFromJson as? NSDictionary  {
                                    // date
                                    if let dt_txt = arrayDictionary.value(forKey: "dt_txt") as? String{
                                        
                                        forecast.dtx=String(dt_txt)
                                        //print(dt_txt)
                                    }
                                    
                                    if let main = arrayDictionary.value(forKey: "main") as? NSDictionary  {
                                        if let humidity = main.value(forKey: "humidity")as? Int64{
                                            forecast.humidity=String(humidity)
                                            
                                        }
                                        if let pressure = main.value(forKey: "pressure") as? Int64{
                                            forecast.pressure=String(pressure)
                                            
                                        }
                                        if let temp_max = main.value(forKey: "temp_max") as? Double{
                                            forecast.temperature_max=String(temp_max)
                                            
                                        }
                                        if let temp_min = main.value(forKey: "temp_min") as? Double{
                                            forecast.temperature_min=String(temp_min)
                                            
                                        }
                                        if let temperature  = main.value(forKey: "temp") as? Double  {
                                            
                                            
                                            
                                            forecast.temperature=String(temperature)
                                            
                                            
                                            
                                            
                                            print("THIS IS THE END",forecast)
                                            
                                            
                                            
                                            
                                        }
                                    }
                                    
                                    if let weather=arrayDictionary.value(forKey: "weather") as? NSArray  {
                                        
                                        var weather_id = (weather[0] as AnyObject).value(forKeyPath: "id") as! Int64
                                        var weather_main = (weather[0] as AnyObject).value(forKeyPath: "main") as! String
                                        var icon = (weather[0] as AnyObject).value(forKeyPath: "icon") as! String
                                        var weather_description = (weather[0] as AnyObject).value(forKeyPath: "description") as! String
                                        
                                        forecast.weather_id=String(weather_id)
                                        forecast.weather_main=String(weather_main)
                                        forecast.icon=String(icon)
                                        forecast.weather_description=String(weather_description)
                                        
                                        //print(weather_description)
                                        
                                    }
                                }
                                
                                self.forecasts?.append(forecast)
                               
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
//                    DispatchQueue.main.async {
//                        result = self.forecasts
//
//                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                result = self.forecasts //or false in case
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result!
        }
        
        return result!
    }
    
    
    
    
   
    
    
    
    func getForeCastListByID(id: String,unit: String) -> [ForeCastStruct] {
        
        var AP=ConfigAP()
        var weatherstruct=WeatherStruct()
        //var currentValues="id=\(id)"
        var forecast = ForeCastStruct()
        var city = CityStruct()
        var result:[ForeCastStruct]?=[]
   
            if let url = URL(string: AP.forecastUrlbyID(unit: unit, id_city: id))
        {
            
            
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "city") as? NSDictionary  {
                            if let id  = mainDictionary.value(forKey: "id") as? Int,
                                let name  = mainDictionary.value(forKey: "name") as? String,
                                let country  = mainDictionary.value(forKey: "country") as? String
                            {
                                if let population  = mainDictionary.value(forKey: "population") as? Int{
                                    city.population=String(population)
                                }
                                    city.id=String(id)
                                    city.name=String(name)
                                    city.country=String(country)
                                
                                
                                
                                
                                
                                //print("THIS IS THE END",city )
                                
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        if let mainArray = jsonObj!.value(forKey: "list") as? NSArray  {
                            
                            
                            //print("THIS IS THE END",mainArray)
                            
                            
                            
                            
                            for resultFromJson in mainArray {
                                
                                forecast.id=city.id
                                forecast.name = city.name
                                forecast.country = city.country
                                forecast.population = city.population
                                
                                
                                if let arrayDictionary = resultFromJson as? NSDictionary  {
                                    // date
                                    if let dt_txt = arrayDictionary.value(forKey: "dt_txt") as? String{
                                        
                                        forecast.dtx=String(dt_txt)
                                        //print(dt_txt)
                                    }
                                    
                                    if let main = arrayDictionary.value(forKey: "main") as? NSDictionary  {
                                        if let humidity = main.value(forKey: "humidity")as? Int64{
                                            forecast.humidity=String(humidity)
                                            
                                        }
                                        if let pressure = main.value(forKey: "pressure") as? Int64{
                                            forecast.pressure=String(pressure)
                                            
                                        }
                                        if let temp_max = main.value(forKey: "temp_max") as? Double{
                                            forecast.temperature_max=String(temp_max)
                                            
                                        }
                                        if let temp_min = main.value(forKey: "temp_min") as? Double{
                                            forecast.temperature_min=String(temp_min)
                                            
                                        }
                                        if let temperature  = main.value(forKey: "temp") as? Double  {
                                            
                                            
                                            
                                            forecast.temperature=String(temperature)
                                            
                                            
                                            
                                            
                                           // print("THIS IS THE END",forecast)
                                            
                                            
                                            
                                            
                                        }
                                    }
                                    
                                    if let weather=arrayDictionary.value(forKey: "weather") as? NSArray  {
                                        
                                        var weather_id = (weather[0] as AnyObject).value(forKeyPath: "id") as! Int64
                                        var weather_main = (weather[0] as AnyObject).value(forKeyPath: "main") as! String
                                        var icon = (weather[0] as AnyObject).value(forKeyPath: "icon") as! String
                                        var weather_description = (weather[0] as AnyObject).value(forKeyPath: "description") as! String
                                        
                                        forecast.weather_id=String(weather_id)
                                        forecast.weather_main=String(weather_main)
                                        forecast.icon=String(icon)
                                        forecast.weather_description=String(weather_description)
                                        
                                        //print(weather_description)
                                        
                                    }
                                }
                                
                                self.forecasts?.append(forecast)
                                // print(resultFromJson)
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
//                    DispatchQueue.main.async {
//                        result = self.forecasts
//
//                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                result = self.forecasts //or false in case
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result!
        }
        
        return result!
    }
    
    
    
    
    
    
    
    
    
    func getfiveForeCastList(forecastParameter:[ForeCastStruct]) -> [[ForeCastStruct]] {
        var dateDeals=DateDeals()
        var weatherstruct=WeatherStruct()
        
        var forecast = ForeCastStruct()
        var city = CityStruct()
        var result:[[ForeCastStruct]]?=[]
        var results:[[ForeCastStruct]]?=[]
        var dateaux=""
        
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
            
            if(index==1){
                
                
                dateaux=forecastParameter[0].dtx
                dateaux=dateDeals.dateToCompare(dateString: dateaux)
                
                
            }else{
                dateaux=dateDeals.addOneDay(dateString: dateaux)
            }
            var result1:[ForeCastStruct]?=[]
            
            for resultFromJson in forecastParameter {
                var datearray=dateDeals.dateToCompare(dateString:resultFromJson.dtx)
                
                if(dateaux==datearray){
                    result1?.append(resultFromJson)
                    //print(datearray)
                    
                    //add forecast to array
                }
                
                
            }
            
            
            
            
            results?.append(result1!)
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        return results!
    }
    
    
    
    
    
    
    
    
    
    
    
    

    
}
