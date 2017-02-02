//
//  Constants.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation
import UIKit

public let EmptyString = ""

struct Constants {
    
    static let BASE_NAME                        = "FinalWeatherBbl"
    static let SQLITE_FILE_NAME                 = BASE_NAME + ".sqlite"
    
    static let FinalWeatherBbl_API_WEATHER_URL  = "http://api.openweathermap.org/data/2.5/weather?"
    static let FinalWeatherBbl_API_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?"
    static let APPID                            = "&APPID=7bb63c2af26702906c55db5122747254"
    
    //MARK: - API'S REQUESTS PARAMS
    
    static let AND                              = "&"
    static let SLASH                            = "/"
    
    static let CITY_NAME                        = "q="
    static let CITY_ID                          = "id="
    
    //MARK: - FONT
    
    struct Fonts {
        struct Roboto {
            static let Black                    = "Roboto-Black"
            static let BlackItalic              = "Roboto-BlackItalic"
            static let Bold                     = "Roboto-Bold"
            static let BoldItalic               = "Roboto-BoldItalic"
            static let Italic                   = "Roboto-Italic"
            static let Light                    = "Roboto-Light"
            static let LightItalic              = "Roboto-LightItalic"
            static let Medium                   = "Roboto-Medium"
            static let MediumItalic             = "Roboto-MediumItalic"
            static let Regular                  = "Roboto-Regular"
            static let Thin                     = "Roboto-Thin"
            static let ThinItalic               = "Roboto-ThinItalic"
            static let Condensed_Bold           = "RobotoCondensed-Bold"
            static let Condensed_BoldItalic     = "RobotoCondensed-BoldItalic"
            static let Condensed_Italic         = "RobotoCondensed-Italic"
            static let Condensed_Light          = "RobotoCondensed-Light"
            static let Condensed_LightItalic    = "RobotoCondensed-LightItalic"
            static let Condensed_Regulard       = "RobotoCondensed-Regular"
        }
    }
    
    //MARK: - WEATHER IMAGES
    
    struct WeatherImageMapper {
        let imageMap = ["01d" : "weather-clear",
                        "02d" : "weather-few",
                        "03d" : "weather-few",
                        "04d" : "weather-broken",
                        "09d" : "weather-shower",
                        "10d" : "weather-rain",
                        "11d" : "weather-tstorm",
                        "13d" : "weather-snow",
                        "50d" : "weather-mist",
                        "01n" : "weather-moon",
                        "02n" : "weather-few-night",
                        "03n" : "weather-few-night",
                        "04n" : "weather-broken",
                        "09n" : "weather-shower",
                        "10n" : "weather-rain-night",
                        "11n" : "weather-tstorm",
                        "13n" : "weather-snow",
                        "50n" : "weather-mist"]
        func imageName(weatherIcon weatherIcon: String) -> String {
            return imageMap[weatherIcon]!
        }
    }
    
    //MARK: - WEEKDAYS
    
    struct WeekDays {
        let dayMap = ["2" : "LUN",
                      "3" : "MAR",
                      "4" : "MER",
                      "5" : "JEU",
                      "6" : "VEN",
                      "7" : "SAM",
                      "1" : "DIM"]
        
        func dayName(dayNumber dayNumber: String) -> String {
            return dayMap[dayNumber]!
        }
    }
    
    //MARK: - METRICS
    
    static let Celcius = "°C"
    
    //MARK: - QOS
    
    struct QOS {
        static let USER_INITIATED = Int(QOS_CLASS_USER_INITIATED.rawValue)
        static let USER_INTERACTIVE = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
    }

    
    //MARK: - ERRORS
    
    struct Domain {
        static let UserServiceDataManager       = "UserServiceDataManager"
    }
    
}

#if !TESTING
    func APP_DELEGATE() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
#endif