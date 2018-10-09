//
//  WeatherStruct.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 02/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
// this estructure is use to store values during long program
struct WeatherStruct: Decodable {
    var id:String = ""
    var main:String = ""
    var icon:String = ""
    var description:String = ""
    
}
