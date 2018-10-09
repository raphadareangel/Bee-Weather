//
//  CurrentController.swift
//  weatherTest
//
//  Created by Rafael Torres Balderas on 03/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import MapKit

class CurrentController{
   
    func mainCurrentLocation(long: String, lat: String,unit: String)-> MainStruct{
        var mainstruct=MainStruct()
        var main=CallMain()
        mainstruct=main.getCurrentMainStruct(long: long, lat: lat, unit: unit)
         return mainstruct
    }
    
    func weatherCurrentLocation(long: String, lat: String, unit :String)-> WeatherStruct{
        var weatherstruct=WeatherStruct()
        var weather=CallWeather()
        weatherstruct=weather.getCurrentWeatherStruct(long: long, lat: lat,unit: unit)
        return weatherstruct
    }
    
    func forecastCurrentLocationByDays(long: String, lat: String,unit: String)-> [[ForeCastStruct]] {
        var forecasts:[ForeCastStruct]?=[]
        var results:[[ForeCastStruct]]?=[]
        var forecast=CallForeCast()
        forecasts=forecast.getCurrentForeCastList(long:long, lat:lat,unit: unit)
        
        results=forecast.getfiveForeCastList(forecastParameter: forecasts!)
        return results!
    }
    //This was the first after changed to 5 days array
//    func forecastCurrentLocation(long: String, lat: String,unit: String, unit :String)-> [ForeCastStruct]{
//        var forecasts:[ForeCastStruct]?=[]
//        
//        var forecast=CallForeCast()
//        forecasts=forecast.getCurrentForeCastList(long:long, lat:lat, unit: unit)
//        forecast.getfiveForeCastList(forecastParameter: forecasts!)
//        return forecasts!
//    }
    


}
