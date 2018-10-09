//
//  File.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 03/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit
class FileReader{
  
    func jsonReader()-> [CityStruct] {
        var citystruct=CityStruct()
        var cities:[CityStruct]?=[]
        let asset = NSDataAsset(name: "city_list_short", bundle: Bundle.main)
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        
        for resultFromJson in json! {
            

            
            
            if let cityDictionary = resultFromJson as? NSDictionary  {
               
                if let id = cityDictionary.value(forKey: "id") as? Int64,
                    let name = cityDictionary.value(forKey: "name") as? String,
                    let country = cityDictionary.value(forKey: "country") as? String
                    {
                    citystruct.id=String(id)
                    citystruct.name=String(name)
                    citystruct.country=String(country)
                   
                    print(citystruct.id)
                }
            }
        
        
            cities?.append(citystruct)
    }
    return cities!
    }
    
}
