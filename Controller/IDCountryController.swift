//
//  IDCountryController.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 03/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation

class IDCountryController{
    
    func mainByID(cityID: String,unit: String)-> MainStruct{
        var mainstruct=MainStruct()
        var main=CallMain()
        mainstruct=main.gettMainStructByID(id: cityID,unit: unit)
        return mainstruct
    }
    
    func weatherByID(cityID: String,unit: String)-> WeatherStruct{
        var weatherstruct=WeatherStruct()
        var weather=CallWeather()
        weatherstruct=weather.getWeatherStructByID(id: cityID,unit:unit)
        return weatherstruct
    }
    
    func forecastByID(cityID: String,unit: String)-> [[ForeCastStruct]]{
        var forecasts:[ForeCastStruct]?=[]
        var results:[[ForeCastStruct]]?=[]
        var forecast=CallForeCast()
        forecasts=forecast.getForeCastListByID(id: cityID,unit: unit)
        results=forecast.getfiveForeCastList(forecastParameter: forecasts!)
        return results!
    }
    
    
}
