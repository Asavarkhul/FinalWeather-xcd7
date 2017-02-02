//
//  UserServiceDataManager.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData
import Alamofire

class UserServiceDataManager: NSObject {
    
    static let sharedInstance = UserServiceDataManager()
    
    internal var tempUri: String?
    
    internal func getDataFromUrl(urL:NSURL, completion: ((_ data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    // MARK: - USER
    
    internal func persistCurrentCityData(managedObjectContext: NSManagedObjectContext, completion: (_ cityObjectID: NSManagedObjectID?, Result<Void, NSError>) -> ()) {
        self.persistCurrentCityData(managedObjectContext, userServiceManager: UserServiceManager.sharedInstance) { (cityObjectID, error) -> Void in
            guard error == nil else {
                return completion(cityObjectID: nil, .Failure(error!))
            }
            completion(cityObjectID: cityObjectID, .Success())
        }
    }
    
    private func persistCurrentCityData(managedObjectContext: NSManagedObjectContext, userServiceManager: UserServiceManager, completion: (cityObjectID: NSManagedObjectID?, error: NSError?) -> Void) {
        
        let usm = userServiceManager
        
        let url = ApiURLManager.sharedInstance.returnCityForCityName(cityName: ContextManager.sharedInstance.initialCityName)
        
        var tempMoc: NSManagedObjectContext?
        do {
            tempMoc = try CoreDataStack.temporaryManagedObjectContextWithParent(managedObjectContext)
        } catch RisedError.TemporaryMocWithParentError {
            completion(cityObjectID: nil, error: Error.TemporaryMocWithParentError)
        } catch {
            completion(cityObjectID: nil, error: Error.MocError)
        }
        
        usm.retreiveResourceForUri(url: url) { (data, error) in
            
            guard error == nil else {
                return completion(cityObjectID: nil, error: Error.NoCity)
            }
            
            guard let cityInfos = data.dictionary ?? nil else {
                return completion(cityObjectID: nil, error: Error.NoInformationsForCurrentCity)
            }
            
            let cityName = String(cityInfos["name"])
            let cityID   = String(cityInfos["sys"]?["id"])
            
            if cityName.characters.count != 0 || cityID.characters.count != 0 {
                let uri = cityName + "_" + cityID
                
                var theCity                         = City.cityForcityUri(uri, moc: tempMoc)
                
                if theCity == nil {
                    theCity                         = City(managedObjectContext: tempMoc)
                }
                
                if theCity != nil {
                    
                    theCity?.cityUri                = uri
                    theCity?.country                = cityInfos["sys"]?["country"].string
                    theCity?.humidity               = cityInfos["main"]?.dictionary?["humidity"]?.stringValue
                    theCity?.id                     = cityInfos["sys"]?.dictionary?["id"]?.stringValue
                    theCity?.latitude               = cityInfos["coord"]?.dictionary?["lat"]?.stringValue
                    theCity?.libel                  = cityInfos["name"]?.string
                    theCity?.longitude              = cityInfos["coord"]?.dictionary?["lon"]?.stringValue
                    theCity?.pressure               = cityInfos["main"]?.dictionary?["pressure"]?.stringValue
                    theCity?.temp                   = cityInfos["main"]?.dictionary?["temp"]?.stringValue
                    theCity?.temp_max               = cityInfos["main"]?.dictionary?["temp_max"]?.doubleValue
                    theCity?.temp_min               = cityInfos["main"]?.dictionary?["temp_min"]?.doubleValue
                    
                    theCity?.todayDate              = NSDate()
                    
                    theCity?.weatherIcon            = cityInfos["weather"]?.array?.first?["icon"].stringValue
                    theCity?.weatherDescription     = cityInfos["weather"]?.array?.first?["description"].stringValue
                    theCity?.weatherID              = cityInfos["weather"]?.array?.first?["id"].stringValue
                    theCity?.weatherMain            = cityInfos["weather"]?.array?.first?["main"].stringValue
                    theCity?.windDeg                = cityInfos["wind"]?.dictionary?["deg"]?.stringValue
                    theCity?.windSpeed              = cityInfos["wind"]?.dictionary?["speed"]?.stringValue
                
                }
                
                defer {
                    var saveError :NSError?
                    CoreDataStack.saveContext(tempMoc, error: &saveError)
                    
                    if saveError == nil {
                        CoreDataStack.saveContext(managedObjectContext, error: &saveError)
                        if saveError == nil {
                            completion(cityObjectID: theCity!.objectID, error: saveError);
                        } else {
                            completion(cityObjectID: nil, error: saveError);
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - FORECAST
    
    internal func persistForecastForCIty(city city: City, managedObjectContext: NSManagedObjectContext, completion: (Result<Void, NSError>) -> ()) {
        self.persistForecastForCIty(city: city, managedObjectContext: managedObjectContext, userServiceManager: UserServiceManager.sharedInstance) { (error) -> Void in
            guard error == nil else {
                return completion(.Failure(error!))
            }
            completion(.Success())
        }
    }
    
    private func persistForecastForCIty(city city: City, managedObjectContext: NSManagedObjectContext, userServiceManager: UserServiceManager, completion: (error: NSError?) -> Void) {
        
        let usm = userServiceManager
        
        let cityMOID = city.objectID
        let parentMOC = city.managedObjectContext
        
        guard city.libel != EmptyString else { return completion(error: Error.NoCity) }
        
        tempUri = ApiURLManager.sharedInstance.returnFiveDaysThreeHoursForecastDataForCityName(cityName: city.libel!)
        
        guard tempUri != EmptyString else { return completion(error: Error.NoUri) }
        
        usm.retreiveResourceForUri(url: tempUri!, completion: { (forecastData, error) -> Void in
            
            guard error == nil else {
                return completion(error: error)
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            
                var tempMoc: NSManagedObjectContext?
                do {
                    tempMoc = try CoreDataStack.temporaryManagedObjectContextWithParent(parentMOC!)
                } catch RisedError.TemporaryMocWithParentError {
                    completion(error: Error.TemporaryMocWithParentError)
                } catch {
                    completion(error: Error.MocError)
                }
                
                let cityLocalInstance = tempMoc?.objectWithID(cityMOID) as! City
                
                let beforeUpdate = cityLocalInstance.cityWeatherForecasts.allObjects as NSArray
                
                let uriBeforeUpdate = (beforeUpdate.valueForKeyPath(ForecastAttributes.uri.rawValue) as! NSArray).mutableCopy() as! NSMutableArray
                
                guard let forecastArray = forecastData["list"].array else {
                    return completion(error: Error.NoForecast)
                }
                
                var index = 0
                var currentdayMonthYearString: String?
                
                for (currentForecast): (JSON) in forecastArray {

                    var forecastUri :String?
                    
                    let forecastId   = String(currentForecast["weather"].array?.first?["id"])
                    let forecastDate = String(currentForecast["dt_txt"])
                    forecastUri      = forecastId + "_" + forecastDate
                    
                    uriBeforeUpdate.removeObject(forecastUri!)
                    
                    var forecast     = Forecast.forecastForForecastUri(forecastUri!, moc: tempMoc)
                    
                    if forecast == nil {
                        forecast     = Forecast(managedObjectContext: tempMoc)
                    }
                    
                    if forecast != nil {
                        
                        forecast?.uri  = forecastUri!
                        forecast?.date = Date.DateFormater.serverDateFormat.dateFromString(String(currentForecast["dt_txt"]))
                        
                        if let t = currentForecast["dt_txt"].string {
                            let v = Date.DateFormater.serverDateFormat.dateFromString(t)
                            let u = v?.shortDate
                            forecast?.dayMonthYearString = u
                            
                            if currentdayMonthYearString != u {
                                index = 0
                            }
                            currentdayMonthYearString = u
                        }
                        
                        forecast?.dayIndex = String(index)
                        index = index + 1
                        
                        if let t = currentForecast["dt_txt"].string {
                            let v = Date.DateFormater.serverDateFormat.dateFromString(t)
                            let u = v?.hourDate
                            forecast?.hourString = u
                        }
                        
                        if let t = currentForecast["dt_txt"].string {
                            let v = Date.DateFormater.serverDateFormat.dateFromString(t)
                            forecast?.dayString = Constants.WeekDays().dayName(dayNumber: (v?.dayOfWeek()?.description)!)
                            let u = v?.hourDate
                            forecast?.hourString = u
                        }
                        
                        forecast?.temp_max = currentForecast["main"].dictionary?["temp_max"]?.doubleValue
                        forecast?.temp_min = currentForecast["main"].dictionary?["temp_min"]?.doubleValue
                        forecast?.weatherIcon = currentForecast["weather"].array?.first?["icon"].stringValue
                        
                        cityLocalInstance.addCityWeatherForecastsObject(forecast)
                    }
                    
                    var saveError :NSError?
                    CoreDataStack.saveContext(tempMoc, error: &saveError)
                    
                    if saveError == nil {
                        CoreDataStack.saveContext(parentMOC, error: &saveError)
                    }
                }
                
                if uriBeforeUpdate.count > 0 {
                    for toBeLocallyDeletedUri in uriBeforeUpdate {
                        if toBeLocallyDeletedUri is NSNull == false {
                            let aForecast =  Forecast.forecastForForecastUri(toBeLocallyDeletedUri as! String, moc: tempMoc)
                            if aForecast != nil {
                                print("deleting object: error(Forecast not exists on server anymore)")
                                tempMoc?.deleteObject(aForecast!)
                            }
                        }
                    }
                }
                
                var saveError :NSError?
                CoreDataStack.saveContext(tempMoc, error: &saveError)
                
                if saveError == nil {
                    CoreDataStack.saveContext(parentMOC, error: &saveError)
                    completion(error: saveError);
                } else {
                    completion(error: saveError);
                }
            }
        })
    }
}
