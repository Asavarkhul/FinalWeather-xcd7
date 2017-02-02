import Foundation
import CoreData

@objc(City)
public class City: _City {

    public class func cityForcityUri(cityUri: String, moc: NSManagedObjectContext!) -> City? {
        var currentcity :City?
        if let currentcityArray = City.fetchCityForCityUri(moc, cityUri: cityUri) as NSArray? {
            if currentcityArray.count>0 {
                currentcity = currentcityArray[0] as? City
            }
        }
        return currentcity
    }
}