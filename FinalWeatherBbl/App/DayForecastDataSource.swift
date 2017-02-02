//
//  DayForecastDataSource.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 29/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol DayForecastDataSourceDelegate {
    ///If one day we want to interact with those cells
}

extension DayForecastDataSource: CellHandler {
    enum CellIdentifier: String {
        case DayForecastCollectionViewCell
    }
}

class DayForecastDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    //MARK: - Outlets & var
    
    internal var delegate : DayForecastDataSourceDelegate?
    
    // MARK: Private
    
    private let collectionView   : UICollectionView
    private var selectedForecast : Forecast?
    
    private func forecastAtIndexPath(indexPath: NSIndexPath) -> Forecast {
        let forecast = fetchedResultsController.objectAtIndexPath(indexPath) as! Forecast
        return forecast
    }
    
    internal init(collectionView: UICollectionView) {
        self.collectionView = collectionView
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
        
        let fetchRequest = Forecast.daysForecastsRequest(managedObjectContext, dayIndex: "0", now: NSDate())
        
        let sortKeyA = ForecastAttributes.date.rawValue
        let sortDescriptorA = NSSortDescriptor(key: sortKeyA, ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptorA]
        
        return fetchRequest
    }
    
    func reset() {
        if let frc = _fetchedResultsController {
            frc.delegate = nil
        }
        _fetchedResultsController = nil
    }
    
    //MARK: - CollectionViewDataSource Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    //Mark: - CollectionView delegates
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let collectionViewCell: UICollectionViewCell?
        
        let forecastCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifierRawRepresentation(.DayForecastCollectionViewCell), forIndexPath: indexPath) as! DayForecastCollectionViewCell
        
        let forecastAtCurrentIndex = forecastAtIndexPath(indexPath)
        
        forecastCell.configure(withDelegate: DayForecastViewModel(withForecast: forecastAtCurrentIndex))
        
        collectionViewCell = forecastCell
        
        collectionViewCell?.frame = CGRectMake(collectionViewCell!.frame.origin.x, collectionViewCell!.frame.origin.y, 100, 100)
        
        return collectionViewCell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK:- NSFetchedResultsControllerDelegate methods
    
    /*
     Assume self has a property 'collectionView' -- as is the case for an instance of a UICollectionViewController
     subclass -- and a method configureCell:atIndexPath: which updates the contents of a given cell
     with information from a managed object at the given index path in the fetched results controller.
     */
    
    // First initialise an array of NSBlockOperations:
    var blockOperations: [NSBlockOperation] = []
    
    // MARK: Deinit
    
    deinit {
        blockOperations.forEach { $0.cancel() }
        blockOperations.removeAll(keepCapacity: false)
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        blockOperations.removeAll(keepCapacity: false)
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            
        case .Insert:
            guard let newIndexPath = newIndexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.insertItemsAtIndexPaths([newIndexPath]) }
            blockOperations.append(op)
            
        case .Update:
            guard let newIndexPath = newIndexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.reloadItemsAtIndexPaths([newIndexPath]) }
            blockOperations.append(op)
            
        case .Move:
            guard let indexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath) }
            blockOperations.append(op)
            
        case .Delete:
            guard let indexPath = indexPath else { return }
            let op = NSBlockOperation { [weak self] in self?.collectionView.deleteItemsAtIndexPaths([indexPath]) }
            blockOperations.append(op)
            
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .Insert:
            let op = NSBlockOperation { [weak self] in self?.collectionView.insertSections(NSIndexSet(index: sectionIndex)) }
            blockOperations.append(op)
            
        case .Update:
            let op = NSBlockOperation { [weak self] in self?.collectionView.reloadSections(NSIndexSet(index: sectionIndex)) }
            blockOperations.append(op)
            
        case .Delete:
            let op = NSBlockOperation { [weak self] in self?.collectionView.deleteSections(NSIndexSet(index: sectionIndex)) }
            blockOperations.append(op)
            
        default: break
            
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.performBatchUpdates({
            self.blockOperations.forEach { $0.start() }
            }, completion: { finished in
                self.blockOperations.removeAll(keepCapacity: false)
        })
    }
    
}