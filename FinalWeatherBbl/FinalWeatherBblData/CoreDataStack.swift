//
//  CoreDataStack.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    //Singleton Swift 1.2 pattern
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.bblch.MoProject" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource(Constants.BASE_NAME, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(Constants.SQLITE_FILE_NAME)
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: mOptions)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if managedObjectContext!.hasChanges {
            managedObjectContext!.performBlockAndWait({ () -> Void in
                do {
                    try self.managedObjectContext!.save()
                } catch let saveError as NSError  {
                    #if DEBUG
                        print("save \(self.managedObjectContext!.description)")
                    #endif
                    NSLog("Unresolved error \(saveError), \(saveError.userInfo)")
                    abort()
                }
            })
        }
    }
    
    class func saveContext(managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) {
        guard let moc = managedObjectContext else {
            return
        }
        if moc.hasChanges {
            moc.performBlockAndWait({ () -> Void in
                do {
                    try moc.save()
                } catch let saveError as NSError  {
                    #if DEBUG
                        print("save \(moc.description)")
                    #endif
                    NSLog("Unresolved error \(saveError), \(saveError.userInfo)")
                    error.memory = saveError
                }
            })
        }
    }
    
    class func saveContextAsync (managedObjectContext: NSManagedObjectContext?, completion: (error: NSError?) -> Void) {
        var saveError: NSError? = nil
        guard let moc = managedObjectContext else {
            return
        }
        if moc.hasChanges {
            moc.performBlockAndWait({ () -> Void in
                do {
                    try moc.save()
                    completion(error: saveError)
                } catch let sError as NSError  {
                    saveError = sError
                    #if DEBUG
                        print("save \(moc.description)")
                    #endif
                    NSLog("Unresolved error \(sError), \(sError.userInfo)")
                    completion(error: saveError)
                }
            })
        }
    }
    
    func temporaryManagedObjectContext() -> NSManagedObjectContext? {
        
        var tempMoc: NSManagedObjectContext?
        do {
            tempMoc = try CoreDataStack.temporaryManagedObjectContextWithParent(self.managedObjectContext!)
        } catch let sError as NSError {
            NSLog("Unresolved error \(sError), \(sError.userInfo)")
            tempMoc = nil
        }
        return tempMoc
    }
    
    class func temporaryManagedObjectContextWithParent(moc: NSManagedObjectContext) throws -> NSManagedObjectContext {
        let tempMoc = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        tempMoc.parentContext = moc
        
        #if DEBUG
            print("\(moc.description) --> \(tempMoc.description)")
        #endif
        
        guard tempMoc.parentContext != nil else { throw RisedError.TemporaryMocWithParentError }
        return tempMoc
    }
}