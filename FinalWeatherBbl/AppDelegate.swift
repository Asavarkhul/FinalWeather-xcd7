//
//  AppDelegate.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(application: UIApplication) {
        CoreDataStack.sharedInstance.saveContext()
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // MARK: - Show Alert
    
    func showAlertWithTitle(title: String, message: String) {
        if NSThread.currentThread().isMainThread {
            let alert :UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction :UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            })
            alert.addAction(defaultAction)
            
            assert(self.window != nil, "self.window can't be nil")
            
            if self.window != nil {
                if self.window!.rootViewController != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.window!.rootViewController!.presentViewController(alert, animated: true, completion: { () -> Void in
                        })
                    }
                }
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.showAlertWithTitle(title, message: message)
            })
        }
    }
}