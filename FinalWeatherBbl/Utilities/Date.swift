//
//  Date.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import UIKit

struct Date {
    
    struct DateFormater {
        
        //MARK: - DATE FORMATER
        
        static var serverDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    formatter.timeZone = NSTimeZone(name: "GMT")
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var yearMonthDayDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    formatter.timeZone = NSTimeZone(name: "GMT")
                    return formatter
                }()
            }
            
            return Static.instance
        }
        
        static var yearMonthDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM"
                    formatter.timeZone = NSTimeZone(name: "GMT")
                    return formatter
                }()
            }
            
            return Static.instance
        }
        
        static var hourFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "HH:mm:ss"
                    formatter.timeZone = NSTimeZone(name: "GMT")
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var hourMinutesFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "HH:mm"
                    formatter.timeZone = NSTimeZone(name: "GMT")
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var simpleDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MM-dd-yyyy", options: 0, locale: NSLocale.currentLocale())
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var dayDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("d", options: 0, locale: NSLocale.currentLocale())
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var monthLitteralDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMMM", options: 0, locale: NSLocale.currentLocale())
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var simpleHourFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("hh:mm:ss", options: 0, locale: NSLocale.currentLocale())
                    return formatter
                }()
            }
            return Static.instance
        }
        
        static var fullDateFormat: NSDateFormatter {
            struct Static {
                static let instance : NSDateFormatter = {
                    let formatter = NSDateFormatter()
                    formatter.dateStyle = .FullStyle
                    return formatter
                }()
            }
            return Static.instance
        }
    }
}