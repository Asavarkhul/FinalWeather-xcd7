//
//  ContextManager.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation
import Alamofire

class ContextManager: NSObject {
    
    //Singleton Swift 1.2 pattern
    static let sharedInstance = ContextManager()

    var currentCity : City?
    
    var initialCityName = "Rouen"
    
    let dataManager = UserServiceDataManager()
    let usm         = UserServiceManager()
    
    func cacheInitialeData(completion: (Result<Void, NSError>) -> ()) {
        
        usm.finalWeatherBblRootLocation = ""
        
        guard let moc = CoreDataStack.sharedInstance.managedObjectContext else {
            print("managedObjectContext instantiation failed in ContextManager")
            return
        }
        
        dataManager.persistCurrentCityData(moc, completion: { (cityObjectID, result) -> Void in
            switch result {
            case .Success:
                if let theCity = cityObjectID {
                    self.currentCity = moc.objectWithID(theCity) as? City
                    completion(.Success())
                    self.dataManager.persistForecastForCIty(city: self.currentCity!, managedObjectContext: moc, completion: { (result) in
                        switch result {
                        case .Success:
                            completion(.Success())
                        case .Failure:
                            completion(.Failure(result.error!))
                        }
                    })
                }
            case .Failure:
                APP_DELEGATE().showAlertWithTitle(InternationalizedStrings.Error.Title.PersistData,
                    message: InternationalizedStrings.Error.Message.RetreiveRessource)
                completion(.Failure(result.error!))
            }
        })
    }
}