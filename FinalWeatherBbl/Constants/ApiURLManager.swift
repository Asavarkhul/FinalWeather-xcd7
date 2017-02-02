//
//  ApiURLManager.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation

class ApiURLManager {
    
    //Singleton Swift 1.2 pattern
    static let sharedInstance = ApiURLManager()
    
    func returnCityForCityName(cityName cityName: String) -> String {
        let url : String?
        if cityName != EmptyString {
            url = Constants.FinalWeatherBbl_API_WEATHER_URL
                + Constants.CITY_NAME
                + cityName
        } else {
            url = EmptyString
        }
        return url!
    }
    
    func returnCityForCityID(cityID cityID: String) -> String {
        let url : String?
        if cityID != EmptyString {
            url = Constants.FinalWeatherBbl_API_WEATHER_URL
                + Constants.CITY_ID
                + cityID
        } else {
            url = EmptyString
        }
        return url!
    }
    
    func returnFiveDaysThreeHoursForecastDataForCityName(cityName cityName: String) -> String {
        let url : String?
        if cityName != EmptyString {
            url = Constants.FinalWeatherBbl_API_FORECAST_URL
                + Constants.CITY_NAME
                + cityName
                + "&mode=json"
        } else {
            url = EmptyString
        }
        return url!
    }
    
    func returnFiveDaysThreeHoursForecastDataForCityID(cityID cityID: String) -> String {
        let url : String?
        if cityID != EmptyString {
            url = Constants.FinalWeatherBbl_API_FORECAST_URL
                + Constants.CITY_ID
                + cityID
                + "&mode=json"
        } else {
            url = EmptyString
        }
        return url!
    }
}