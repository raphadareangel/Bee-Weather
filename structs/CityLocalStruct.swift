//
//  MovieLocalStruct.swift
//  FinalTest
//
//  Created by Rafael Torres Balderas on 20/02/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct cityItem {
    
    var id:String?
    var name:String?
    var country:String?
    var population:String?
    
   
    
    
    
    init() {
        id = ""
        name = ""
        country = ""
        population = ""
        
        
        
        
    }
    
    init(id:String,name:String,country:String,
         population:String) {
        self.id = id
        self.name = name
        self.country = country
        self.population = population
    }
    
}
