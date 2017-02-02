// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.swift instead.

import CoreData

public enum CityAttributes: String {
    case cityUri = "cityUri"
    case country = "country"
    case humidity = "humidity"
    case id = "id"
    case latitude = "latitude"
    case libel = "libel"
    case longitude = "longitude"
    case pressure = "pressure"
    case temp = "temp"
    case temp_max = "temp_max"
    case temp_min = "temp_min"
    case todayDate = "todayDate"
    case weatherDescription = "weatherDescription"
    case weatherID = "weatherID"
    case weatherIcon = "weatherIcon"
    case weatherMain = "weatherMain"
    case windDeg = "windDeg"
    case windSpeed = "windSpeed"
}

public enum CityRelationships: String {
    case cityWeatherForecasts = "cityWeatherForecasts"
}

@objc
public class _City: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "City"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _City.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    public var cityUri: String?

    // public func validateCityUri(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var country: String?

    // public func validateCountry(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var humidity: String?

    // public func validateHumidity(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var id: String?

    // public func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var latitude: String?

    // public func validateLatitude(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var libel: String?

    // public func validateLibel(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var longitude: String?

    // public func validateLongitude(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var pressure: String?

    // public func validatePressure(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var temp: String?

    // public func validateTemp(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var temp_max: NSNumber?

    // public func validateTemp_max(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var temp_min: NSNumber?

    // public func validateTemp_min(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var todayDate: NSDate?

    // public func validateTodayDate(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var weatherDescription: String?

    // public func validateWeatherDescription(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var weatherID: String?

    // public func validateWeatherID(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var weatherIcon: String?

    // public func validateWeatherIcon(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var weatherMain: String?

    // public func validateWeatherMain(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var windDeg: String?

    // public func validateWindDeg(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var windSpeed: String?

    // public func validateWindSpeed(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    public var cityWeatherForecasts: NSSet

public class func cityForCityUriRequest(managedObjectContext: NSManagedObjectContext!, cityUri: String) -> NSFetchRequest {

    let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
    let substitutionVariables:[String:AnyObject] = [
    "cityUri": cityUri,
    ]

    let fetchRequest = model.fetchRequestFromTemplateWithName("cityForCityUri", substitutionVariables: substitutionVariables)!

    return fetchRequest
}

    public class func fetchCityForCityUri(managedObjectContext: NSManagedObjectContext!, cityUri: String) -> [AnyObject] {
        return self.fetchCityForCityUri(managedObjectContext, cityUri: cityUri, error: nil)
    }

    public class func fetchCityForCityUri(managedObjectContext: NSManagedObjectContext!, cityUri: String, error outError: NSErrorPointer) -> [AnyObject] {
        let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let substitutionVariables:[String:AnyObject] = [
            "cityUri": cityUri,
]

        let fetchRequest = model.fetchRequestFromTemplateWithName("cityForCityUri", substitutionVariables: substitutionVariables)!

        var results : [AnyObject]? = nil

        do {
            results = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let fetchError as NSError {
            outError.memory = fetchError
        }

        return results!
    }

public class func cityForCityIDRequest(managedObjectContext: NSManagedObjectContext!, id: String) -> NSFetchRequest {

    let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
    let substitutionVariables:[String:AnyObject] = [
    "id": id,
    ]

    let fetchRequest = model.fetchRequestFromTemplateWithName("cityForCityID", substitutionVariables: substitutionVariables)!

    return fetchRequest
}

    public class func fetchCityForCityID(managedObjectContext: NSManagedObjectContext!, id: String) -> [AnyObject] {
        return self.fetchCityForCityID(managedObjectContext, id: id, error: nil)
    }

    public class func fetchCityForCityID(managedObjectContext: NSManagedObjectContext!, id: String, error outError: NSErrorPointer) -> [AnyObject] {
        let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let substitutionVariables:[String:AnyObject] = [
            "id": id,
]

        let fetchRequest = model.fetchRequestFromTemplateWithName("cityForCityID", substitutionVariables: substitutionVariables)!

        var results : [AnyObject]? = nil

        do {
            results = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let fetchError as NSError {
            outError.memory = fetchError
        }

        return results!
    }

}

extension _City {

    public func addCityWeatherForecasts(objects: NSSet) {
        let mutable = NSMutableSet(set: self.cityWeatherForecasts)
        mutable.unionSet(objects as! Set<NSObject>)
        self.cityWeatherForecasts = NSSet(set: mutable)
    }

    public func removeCityWeatherForecasts(objects: NSSet) {
        let mutable = NSMutableSet(set: self.cityWeatherForecasts)
        mutable.minusSet(objects as! Set<NSObject>)
        self.cityWeatherForecasts = NSSet(set: mutable)
    }

    public func addCityWeatherForecastsObject(value: Forecast!) {
        let mutable = NSMutableSet(set: self.cityWeatherForecasts)
        mutable.addObject(value)
        self.cityWeatherForecasts = NSSet(set: mutable)
    }

    public func removeCityWeatherForecastsObject(value: Forecast!) {
        let mutable = NSMutableSet(set: self.cityWeatherForecasts)
        mutable.removeObject(value)
        self.cityWeatherForecasts = NSSet(set: mutable)
    }
}
