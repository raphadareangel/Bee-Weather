//
//  Config.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 02/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation

class ConfigAP{
    let base_url = "https://api.openweathermap.org/data/2.5/"
    var weather: String = "weather?"
    var forecast: String="forecast?"
    var api_key: String="APPID=e03484e3ab6ace022b024d6b1aa41fd3"
    var units: String="&units="
    var id: String="&id="
    var query : String="&q="
    var long : String="&lon="
    var lat : String="&lat="
    var separator : String=","
    
    let icon_url  = "https://openweathermap.org/img/w/"
    
    func weatherUrlbyID(unit:String, id_city:String) -> String {
    var urlweather=base_url+weather+api_key+units+unit+id+id_city
        return urlweather
    }
   
    func weatherUrlbyLonandLat(unit:String, lat_city:String, long_city:String) -> String {
        var urlweather=base_url+weather+api_key+units+unit+lat+lat_city+long+long_city
        return urlweather
    }
    func weatherUrlbycity(unit:String, city_name :String , city_country :String) -> String {
        var urlweather=base_url+weather+api_key+units+unit+query+city_name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!+separator+city_country.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return urlweather
    }
    
    func forecastUrlbyID(unit:String, id_city:String) -> String {
        var urlforecast=base_url+forecast+api_key+units+unit+id+id_city
        return urlforecast
    }
    
    func forecastUrlbyLonandLat(unit:String, lat_city:String, long_city:String) -> String {
        var urlforecast=base_url+forecast+api_key+units+unit+lat+lat_city+long+long_city
        return urlforecast
    }
    func forecastUrlbycity(unit:String, city_name :String , city_country :String) -> String {
        var urlforecast=base_url+forecast+api_key+units+unit+query+city_name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!+separator+city_country.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return urlforecast
    }
}
