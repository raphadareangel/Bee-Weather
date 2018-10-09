//
//  ForeCastStruct.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 02/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation


struct ForeCastStruct: Decodable {
    var id:String=""
    var name:String = ""
    var country:String = ""
    var population:String = ""
    
    var dtx:String = ""
    
    var temperature:String=""
    var temperature_max  :String=""
    var temperature_min  :String=""
    var pressure  :String=""
    var humidity  :String=""
    
    var weather_id :String=""
    var weather_main :String=""
    var icon :String=""
    var weather_description :String=""
    
    
}
