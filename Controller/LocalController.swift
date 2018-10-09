//
//  LocalController.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 03/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation

class LocalController{
    
    
    func loadcities() -> [CityStruct] {
        var cities:[CityStruct]?=[]
        var filereader=FileReader()
        cities=filereader.jsonReader()
        
        return cities!
    }
}
