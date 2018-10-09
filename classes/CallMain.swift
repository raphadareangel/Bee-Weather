//
//  CallW.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 01/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
class CallMain{
    
    var test = MainStruct()

    
    // ##########################################################################
    // This is the one
     // I need to refactor after demo to show handle data types
    func getMainStruct() -> MainStruct {
        
        var mainstruct=MainStruct()
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Atlanta,us?&units=imperial&APPID=e03484e3ab6ace022b024d6b1aa41fd3")!
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Atlanta,us?&units=imperial&APPID=e03484e3ab6ace022b024d6b1aa41fd3") {
            
            var result=MainStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        
                            if let main_city = jsonObj?.value(forKey: "name") as? String{
                        
                                mainstruct.main_city=String(main_city )
                                print(mainstruct.main_city)
                                }
                        
                        if let countryDictionary = jsonObj!.value(forKey: "sys") as? NSDictionary {
                            if let country  = countryDictionary.value(forKey: "country") as? String {
                                
                                
                                
                                mainstruct.country=String(country)
                                
                                print("THIS IS THE END",country)
                                
                                
                            }
                        }
                        
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature  = mainDictionary.value(forKey: "temp") as? Double,let humidity = mainDictionary.value(forKey: "humidity")as? Int64, let pressure = mainDictionary.value(forKey: "pressure") as? Int64, let temp_max = mainDictionary.value(forKey: "temp_max") as? Double, let temp_min = mainDictionary.value(forKey: "temp_min") as? Double  {
                                
                                
                                
                                mainstruct.temp=String(temperature)
                                mainstruct.humidity=String(humidity)
                                mainstruct.pressure=String(pressure)
                                mainstruct.temp_max=String(temp_max)
                                mainstruct.temp_min=String(temp_min)
                                print("THIS IS THE END",mainstruct)
                                
                                
                                
                                
                            }
                           
                        }
                        
                    }
                    DispatchQueue.main.async {
                        // self.tableView.reloadData()
                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = mainstruct //main struct
                semaphore.signal()  //count it up
            }).resume()
            
            semaphore.wait()  //wait for finished counting
            
            return result
        }
        
        return mainstruct
    }
    
    
    
    
    
    func getCurrentMainStruct(long: String, lat: String, unit: String) -> MainStruct {
       
        var AP=ConfigAP()
        var mainstruct=MainStruct()
        var currentValues="lat=\(lat)&lon=\(long)"
     
      
        if let url = URL(string: AP.weatherUrlbyLonandLat(unit: unit, lat_city: lat, long_city: long)) {
            
            var result=MainStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                
                
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        
                        if let main_city = jsonObj?.value(forKey: "name") as? String{
                            
                            mainstruct.main_city=String(main_city )
                            print(mainstruct.main_city)
                        }
                        
                        if let countryDictionary = jsonObj!.value(forKey: "sys") as? NSDictionary {
                            if let country  = countryDictionary.value(forKey: "country") as? String {
                                
                                
                                
                                mainstruct.country=String(country)
                                
                                print("THIS IS THE END",country)
                                
                                
                            }
                        }
                        
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let humidity = mainDictionary.value(forKey: "humidity")as? Int64{
                                mainstruct.humidity=String(humidity)
                                
                            }
                            if let pressure = mainDictionary.value(forKey: "pressure") as? Int64{
                                mainstruct.pressure=String(pressure)
                                
                            }
                            if let temp_max = mainDictionary.value(forKey: "temp_max") as? Double{
                                mainstruct.temp_max=String(temp_max)
                                
                            }
                            if let temp_min = mainDictionary.value(forKey: "temp_min") as? Double{
                                mainstruct.temp_min=String(temp_min)
                                
                            }
                            if let temperature  = mainDictionary.value(forKey: "temp") as? Double  {
                                
                                
                                
                                mainstruct.temp=String(temperature)
                                
                                
                                
                                
                                print("THIS IS THE END",mainstruct)
                                
                                
                                
                                
                            }
                            
                        }
                        
                    }
//                    DispatchQueue.main.async {
//                        // self.tableView.reloadData()
//                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = mainstruct //mainstruct
                semaphore.signal()  //count it up
            }).resume()
            
            semaphore.wait()  // wait for finished counting
            
            return result
        }
        
        return mainstruct
    }
    
    
    func gettMainStructByCity(city_name: String,city_country: String, unit: String) -> MainStruct {
        var imperial:String="imperial"
        var AP=ConfigAP()
        var mainstruct=MainStruct()
     
         if let url = URL(string: AP.weatherUrlbycity(unit: unit, city_name: city_name, city_country: city_country))
            {
        
            var result=MainStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
               
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        
                        if let main_city = jsonObj?.value(forKey: "name") as? String{
                            
                            mainstruct.main_city=String(main_city )
                            print(mainstruct.main_city)
                        }
                        
                        if let countryDictionary = jsonObj!.value(forKey: "sys") as? NSDictionary {
                            if let country  = countryDictionary.value(forKey: "country") as? String {
                                
                                
                                
                                mainstruct.country=String(country)
                                
                                print("THIS IS THE END",country)
                                
                                
                            }
                        }
                        
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let humidity = mainDictionary.value(forKey: "humidity")as? Int64{
                                mainstruct.humidity=String(humidity)
                                
                            }
                            if let pressure = mainDictionary.value(forKey: "pressure") as? Int64{
                                mainstruct.pressure=String(pressure)
                                
                            }
                            if let temp_max = mainDictionary.value(forKey: "temp_max") as? Double{
                                mainstruct.temp_max=String(temp_max)
                                
                            }
                            if let temp_min = mainDictionary.value(forKey: "temp_min") as? Double{
                                mainstruct.temp_min=String(temp_min)
                                
                            }
                            if let temperature  = mainDictionary.value(forKey: "temp") as? Double  {
                                
                                
                                
                                mainstruct.temp=String(temperature)
                                
                                
                                
                                
                                print("THIS IS THE END",mainstruct)
                                
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        // self.tableView.reloadData()
                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = mainstruct //mainstruct
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            return result
        }
        
        return mainstruct
    }


    func gettMainStructByID(id: String, unit: String) -> MainStruct {
       
        var AP=ConfigAP()
        var mainstruct=MainStruct()
        var currentValues="id=\(id)"
  
        if let url = URL(string: AP.weatherUrlbyID(unit: unit, id_city: id)) {
            
            var result=MainStruct()
            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
            
            let session = URLSession.shared
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                if (error != nil) {
                    print(error!)
                    return
                }
                
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        
                        if let main_city = jsonObj?.value(forKey: "name") as? String{
                            
                            mainstruct.main_city=String(main_city )
                            print(mainstruct.main_city)
                        }
                        
                        if let countryDictionary = jsonObj!.value(forKey: "sys") as? NSDictionary {
                            if let country  = countryDictionary.value(forKey: "country") as? String {
                                
                                
                                
                                mainstruct.country=String(country)
                                
                                print("THIS IS THE END",country)
                                
                                
                            }
                        }
                        
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                           if let humidity = mainDictionary.value(forKey: "humidity")as? Int64{
                                mainstruct.humidity=String(humidity)
                                
                            }
                            if let pressure = mainDictionary.value(forKey: "pressure") as? Int64{
                                mainstruct.pressure=String(pressure)
                                
                            }
                            if let temp_max = mainDictionary.value(forKey: "temp_max") as? Double{
                                 mainstruct.temp_max=String(temp_max)
                                
                            }
                            if let temp_min = mainDictionary.value(forKey: "temp_min") as? Double{
                                mainstruct.temp_min=String(temp_min)
                                
                            }
                            if let temperature  = mainDictionary.value(forKey: "temp") as? Double  {
                                
                               
                                
                                mainstruct.temp=String(temperature)
                                
                                
                               
                                
                                print("THIS IS THE END",mainstruct)
                                
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                    }
//                    DispatchQueue.main.async {
//                        // self.tableView.reloadData()
//                    }
                    
                }catch let error{
                    print(error)
                    
                }
                
                
                
                
                
                result = mainstruct //mainstruct
                semaphore.signal()  //3. count it up
            }).resume()
            
            semaphore.wait()  //2. wait for finished counting
            
            //return result
        }
        
        return mainstruct
    }

}






