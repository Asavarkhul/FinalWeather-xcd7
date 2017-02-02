//
//  HourForecastDataSource.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 29/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol HourForecastDataSourceDelegate {
    ///If one day we want to interact with those cells
}

extension HourForecastDataSource: CellHandler {
    enum CellIdentifier: String {
        case HourForecastTableViewCell
    }
}

class HourForecastDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    //MARK: - Outlets & var
    
    internal var delegate : HourForecastDataSourceDelegate?
    
    // MARK: Private
    
    private let tableView        : UITableView
    private var selectedForecast : Forecast?
    
    private func forecastAtIndexPath(indexPath: NSIndexPath) -> Forecast {
        let forecast = fetchedResultsController.objectAtIndexPath(indexPath) as! Forecast
        return forecast
    }
    
    internal init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
    
    // MARK:- NSFetchedResultsController
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = self.fetchRequest()
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        aFetchedResultsController.delegate = self
        
        var error: NSError? = nil
        do {
            try aFetchedResultsController.performFetch()
        } catch let error1 as NSError {
            error = error1
            print(error)
        }
        
        _fetchedResultsController = aFetchedResultsController
        
        return _fetchedResultsController!
        
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func fetchRequest() -> NSFetchRequest {
        let managedObjectContext = CoreDataStack.sharedInstance.managedObjectContext!
        
        let fetchRequest = Forecast.todayForecastsRequest(managedObjectContext, dayMonthYearString: NSDate().shortDate, now: NSDate())
        
        let sortKey = ForecastAttributes.hourString.rawValue
        let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func reset() {
        if let frc = _fetchedResultsController {
            frc.delegate = nil
        }
        _fetchedResultsController = nil
    }
    
    // MARK:- UITableViewDataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell: UITableViewCell?
        
        let forecastAtCurrentIndex = forecastAtIndexPath(indexPath)
        
        let forecastCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierRawRepresentation(.HourForecastTableViewCell)) as! HourForecastTableViewCell
        
        forecastCell.configure(withDelegate: HourForecastViewModel(withForecast: forecastAtCurrentIndex))
        
        tableViewCell = forecastCell
        
        return tableViewCell!
    }
    
    
    // MARK:- UITableViewDelegate methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height:CGFloat
        
        height = 50.0
        
        return height
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins  = UIEdgeInsetsZero
    }
    
    // MARK:- NSFetchedResultsControllerDelegate methods
    
    /*
     Assume self has a property 'tableView' -- as is the case for an instance of a UITableViewController
     subclass -- and a method configureCell:atIndexPath: which updates the contents of a given cell
     with information from a managed object at the given index path in the fetched results controller.
     */
    
    
    /// Temp fix for empty row issue : http://stackoverflow.com/a/33436182/4691203
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Update:
            if let indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        case .Insert: tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Delete: tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Move:
            if indexPath != newIndexPath {
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            }
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType){
        switch(type) {
        case NSFetchedResultsChangeType.Insert:
            tableView.insertSections(NSIndexSet(index:sectionIndex), withRowAnimation:UITableViewRowAnimation.Automatic)
        case NSFetchedResultsChangeType.Delete:
            tableView.deleteSections(NSIndexSet(index:sectionIndex), withRowAnimation:UITableViewRowAnimation.Automatic)
        default:
            break
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController){
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController){
        tableView.endUpdates()
    }
}