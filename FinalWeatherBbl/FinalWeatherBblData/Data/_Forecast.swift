// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Forecast.swift instead.

import CoreData

public enum ForecastAttributes: String {
    case date = "date"
    case dayIndex = "dayIndex"
    case dayMonthYearString = "dayMonthYearString"
    case dayString = "dayString"
    case hourString = "hourString"
    case libel = "libel"
    case temp_max = "temp_max"
    case temp_min = "temp_min"
    case uri = "uri"
    case weatherIcon = "weatherIcon"
}

public enum ForecastRelationships: String {
    case city = "city"
}

@objc
public class _Forecast: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Forecast"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _Forecast.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    public var date: NSDate?

    // public func validateDate(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var dayIndex: String?

    // public func validateDayIndex(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var dayMonthYearString: String?

    // public func validateDayMonthYearString(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var dayString: String?

    // public func validateDayString(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var hourString: String?

    // public func validateHourString(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var libel: String?

    // public func validateLibel(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var temp_max: NSNumber?

    // public func validateTemp_max(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var temp_min: NSNumber?

    // public func validateTemp_min(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var uri: String?

    // public func validateUri(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    public var weatherIcon: String?

    // public func validateWeatherIcon(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    public var city: City?

    // public func validateCity(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

public class func forecastForForecastUriRequest(managedObjectContext: NSManagedObjectContext!, uri: String) -> NSFetchRequest {

    let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
    let substitutionVariables:[String:AnyObject] = [
    "uri": uri,
    ]

    let fetchRequest = model.fetchRequestFromTemplateWithName("forecastForForecastUri", substitutionVariables: substitutionVariables)!

    return fetchRequest
}

    public class func fetchForecastForForecastUri(managedObjectContext: NSManagedObjectContext!, uri: String) -> [AnyObject] {
        return self.fetchForecastForForecastUri(managedObjectContext, uri: uri, error: nil)
    }

    public class func fetchForecastForForecastUri(managedObjectContext: NSManagedObjectContext!, uri: String, error outError: NSErrorPointer) -> [AnyObject] {
        let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let substitutionVariables:[String:AnyObject] = [
            "uri": uri,
]

        let fetchRequest = model.fetchRequestFromTemplateWithName("forecastForForecastUri", substitutionVariables: substitutionVariables)!

        var results : [AnyObject]? = nil

        do {
            results = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let fetchError as NSError {
            outError.memory = fetchError
        }

        return results!
    }

public class func todayForecastsRequest(managedObjectContext: NSManagedObjectContext!, dayMonthYearString: String, now: NSDate) -> NSFetchRequest {

    let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
    let substitutionVariables:[String:AnyObject] = [
    "dayMonthYearString": dayMonthYearString,

    "now": now,
    ]

    let fetchRequest = model.fetchRequestFromTemplateWithName("todayForecasts", substitutionVariables: substitutionVariables)!

    return fetchRequest
}

    public class func fetchTodayForecasts(managedObjectContext: NSManagedObjectContext!, dayMonthYearString: String, now: NSDate) -> [AnyObject] {
        return self.fetchTodayForecasts(managedObjectContext, dayMonthYearString: dayMonthYearString, now: now, error: nil)
    }

    public class func fetchTodayForecasts(managedObjectContext: NSManagedObjectContext!, dayMonthYearString: String, now: NSDate, error outError: NSErrorPointer) -> [AnyObject] {
        let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let substitutionVariables:[String:AnyObject] = [
            "dayMonthYearString": dayMonthYearString,

            "now": now,
]

        let fetchRequest = model.fetchRequestFromTemplateWithName("todayForecasts", substitutionVariables: substitutionVariables)!

        var results : [AnyObject]? = nil

        do {
            results = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let fetchError as NSError {
            outError.memory = fetchError
        }

        return results!
    }

public class func allForecastRequest(managedObjectContext: NSManagedObjectContext!) -> NSFetchRequest {

    let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
    let substitutionVariables:[String:AnyObject] = [:]

    let fetchRequest = model.fetchRequestFromTemplateWithName("allForecast", substitutionVariables: substitutionVariables)!

    return fetchRequest
}

    public class func fetchAllForecast(managedObjectContext: NSManagedObjectContext!) -> [AnyObject] {
        return self.fetchAllForecast(managedObjectContext, error: nil)
    }

    public class func fetchAllForecast(managedObjectContext: NSManagedObjectContext!, error outError: NSErrorPointer) -> [AnyObject] {
        let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let substitutionVariables:[String:AnyObject] = [:]

        let fetchRequest = model.fetchRequestFromTemplateWithName("allForecast", substitutionVariables: substitutionVariables)!

        var results : [AnyObject]? = nil

        do {
            results = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let fetchError as NSError {
            outError.memory = fetchError
        }

        return results!
    }

public class func daysForecastsRequest(managedObjectContext: NSManagedObjectContext!, dayIndex: String, now: NSDate) -> NSFetchRequest {

    let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
    let substitutionVariables:[String:AnyObject] = [
    "dayIndex": dayIndex,

    "now": now,
    ]

    let fetchRequest = model.fetchRequestFromTemplateWithName("daysForecasts", substitutionVariables: substitutionVariables)!

    return fetchRequest
}

    public class func fetchDaysForecasts(managedObjectContext: NSManagedObjectContext!, dayIndex: String, now: NSDate) -> [AnyObject] {
        return self.fetchDaysForecasts(managedObjectContext, dayIndex: dayIndex, now: now, error: nil)
    }

    public class func fetchDaysForecasts(managedObjectContext: NSManagedObjectContext!, dayIndex: String, now: NSDate, error outError: NSErrorPointer) -> [AnyObject] {
        let model = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let substitutionVariables:[String:AnyObject] = [
            "dayIndex": dayIndex,

            "now": now,
]

        let fetchRequest = model.fetchRequestFromTemplateWithName("daysForecasts", substitutionVariables: substitutionVariables)!

        var results : [AnyObject]? = nil

        do {
            results = try managedObjectContext.executeFetchRequest(fetchRequest)
        } catch let fetchError as NSError {
            outError.memory = fetchError
        }

        return results!
    }

}

