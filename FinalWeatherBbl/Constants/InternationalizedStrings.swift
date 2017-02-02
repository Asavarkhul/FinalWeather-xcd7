//
//  InternationalizedStrings.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation

struct InternationalizedStrings {
    
    static let Loading                      = NSLocalizedString("Chargement...", comment: "")
    
    struct Alert {
        struct Title {
            static let Error                = NSLocalizedString("context_AlertView_Title_Error", comment: "")
        }
        struct Message {
            static let MocError             = NSLocalizedString("context_UserServiceDataManager_Moc_Error", comment: "")
        }
    }
    
    struct Error {
        struct Title {
            static let PersistData          = NSLocalizedString("Problème de connexion", comment: "login failed message title")
            static let LoginFailed          = NSLocalizedString("context_ContextManager_Login_impossible", comment: "login failed message title")
        }
        struct Message {
            static let NoForecast           = NSLocalizedString("context_UserServiceDataManager_Error_Forecast", comment: "")
            static let MocError             = NSLocalizedString("context_UserServiceDataManager_Moc_Error", comment: "")
            static let TempMocError         = NSLocalizedString("context_UserServiceDataManager_TempMoc_Error", comment: "")
            static let NoCity               = NSLocalizedString("context_UserServiceDataManager_Error_NoCity", comment: "")
            static let NoInformationsForCurrentCity = NSLocalizedString("context_UserServiceDataManager_Error_NoInformationsForCurrentCity", comment: "")
            static let NoUri                = NSLocalizedString("context_UserServiceDataManager_Error_NoUri", comment: "")
            static let RetreiveRessource    = NSLocalizedString("Une erreur réseau est survenue, veuillez vous reconnecter et relancer l'application pour charger les dernières données.", comment: "")
            static let LoginImpossible      = NSLocalizedString("context_ContextManager_Login_impossible", comment: "Could not login message")
        }
    }
}