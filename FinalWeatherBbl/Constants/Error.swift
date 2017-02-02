//
//  Error.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation

/// Look at https://www.youtube.com/watch?v=pHsvYPMqsOc

enum RisedError: ErrorType {
    case TemporaryMocWithParentError
    case NilSpotError
    case MocError
    case Short
    case Obvious(String)
}

struct Error {
    
    static let NoUri = NSError(domain: Constants.Domain.UserServiceDataManager,
                               code:2,
                               userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.NoUri])
    
    static let MocError = NSError(domain: Constants.Domain.UserServiceDataManager,
                                  code:2,
                                  userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.MocError])
    
    static let TemporaryMocWithParentError = NSError(domain: Constants.Domain.UserServiceDataManager,
                                                     code:2,
                                                     userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.TempMocError])
    
    static let NoCity  = NSError(domain: Constants.Domain.UserServiceDataManager,
                                   code:2,
                                   userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.NoCity])
    
    static let NoForecast  = NSError(domain: Constants.Domain.UserServiceDataManager,
                                 code:2,
                                 userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.NoForecast])
    
    static let NoInformationsForCurrentCity = NSError(domain: Constants.Domain.UserServiceDataManager,
                                          code:2,
                                          userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.NoInformationsForCurrentCity])
    
    static let RetreiveError = NSError(domain: Constants.Domain.UserServiceDataManager,
                                       code:1,
                                       userInfo: [NSLocalizedDescriptionKey:InternationalizedStrings.Error.Message.RetreiveRessource])
}