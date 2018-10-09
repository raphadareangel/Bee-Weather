//
//  NameCountryController.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 03/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation


class NameCountryController{
    
    func mainByCity(city_name: String, city_country: String,unit :String)-> MainStruct{
        var mainstruct=MainStruct()
        var main=CallMain()
        mainstruct=main.gettMainStructByCity(city_name: city_name,city_country: city_country, unit:unit)
        return mainstruct
    }
    
    func weatherByCity(city_name: String, city_country: String,unit :String)-> WeatherStruct{
        var weatherstruct=WeatherStruct()
        var weather=CallWeather()
        weatherstruct=weather.getWeatherStructByCity(city_name: city_name, city_country: city_country,unit: unit)
        return weatherstruct
    }
    
    func forecastBycity(city_name: String, city_country: String,unit :String)-> [[ForeCastStruct]]{
        var forecasts:[ForeCastStruct]?=[]
        var results:[[ForeCastStruct]]?=[]
        var forecast=CallForeCast()
        forecasts=forecast.getForeCastListByCity(city_name: city_name, city_country: city_country,unit:unit)
        
        results=forecast.getfiveForeCastList(forecastParameter: forecasts!)
        return results!
    }
    
    
}
