//
//  CellHandlerType.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit
import Foundation

protocol CellHandler {
    associatedtype CellIdentifier: RawRepresentable
}

extension CellHandler where Self: NSObject, CellIdentifier.RawValue == String {
    
    internal func cellIdentifierRawRepresentation(cellIdentifier: CellIdentifier) -> String {
        return cellIdentifier.rawValue
    }
    
    internal func cellIdentifierForCell(cell: UITableViewCell) -> CellIdentifier {
        
        guard let identifier = cell.reuseIdentifier, cellIdentifier = CellIdentifier(rawValue: identifier) else {
            fatalError("Ivalid cell identifier \(cell.reuseIdentifier).")
        }
        
        return cellIdentifier
    }
}