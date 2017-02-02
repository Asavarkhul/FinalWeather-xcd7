//
//  UserServiceManager.swift
//  FinalWeatherBbl
//
//  Created by Bertrand on 28/06/2016.
//  Copyright © 2016 Bertrand Bloc'h. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum PushMethod: String {
    case POST = "POST"
    case PUT  = "PUT"
}

public enum UserServiceManagerKeys: String {
    
    case MCSessionKey   = "MCSession"
    case ContentTypeKey = "Content-Type"
    case HTTPStatusCode = "HTTPStatusCode"
}

class UserServiceManager: NSObject {
    
    
    //Singleton Swift 1.2 pattern
    static let sharedInstance = UserServiceManager()
    
    var finalWeatherBblRootLocation :String?
    
    
    // MARK: - Rest Methods
    
    
    func post(url: String, parameters: [String : AnyObject]?, loginRequest: Bool, completion: (createdObjectHref: String?, error: NSError?, data: JSON?) -> Void) {
        if self.finalWeatherBblRootLocation != nil {
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [UserServiceManagerKeys.MCSessionKey.rawValue : self.finalWeatherBblRootLocation!]
        }
        
        Alamofire.request(.POST, url+Constants.APPID, parameters: parameters, encoding: .JSON)
            .responseJSON { response -> Void in
                
//                dispatch_async(dispatch_get_main_queue()) {
//                    print("#######################")
//                    print("REQUEST : \(response.request!)")
//                    print("#######################")
//                    print("RESPONSE : \(response.response!)")
//                    print("#######################")
//                    print("DATA : \(response.result.value)")
//                    print("#######################")
//                    print("ERROR : \(response.result.error)")
//                    print("#######################")
//                }
                
                
                guard response.result.error == nil else {
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let data :AnyObject = response.result.value {
                        var resp = JSON(data)
                        if response.response != nil {
                            if response.response?.statusCode != 200 && response.response?.statusCode != 201  {
                                let theError = NSError(domain: "UserServiceManager", code:1, userInfo: [NSLocalizedDescriptionKey:"Creation failed - httpStatus \(response.response?.statusCode)  (\(url))", UserServiceManagerKeys.HTTPStatusCode.rawValue:(response.response?.statusCode)!])
                                completion(createdObjectHref: nil, error: theError, data: nil)
                            }
                        }
                        if (response.result.error == nil) {
                            if loginRequest == true {
                                if response.response?.statusCode == 200 || response.response?.statusCode == 201  {
                                    if resp["error"].bool == false {
                                        completion(createdObjectHref: "", error: nil, data: resp)
                                    } else {
                                        let theError = NSError(domain: "UserServiceManager", code:1, userInfo: [NSLocalizedDescriptionKey:"Login Error \(response.result.error)"])
                                        completion(createdObjectHref: nil, error: theError, data: nil)
                                    }
                                } else {
                                    let theError = NSError( domain: "UserServiceManager", code:1, userInfo: [NSLocalizedDescriptionKey:"Creation failed - httpStatus \(response.response?.statusCode)  (\(url))", UserServiceManagerKeys.HTTPStatusCode.rawValue:(response.response?.statusCode)!])
                                    completion(createdObjectHref: nil, error: theError, data: nil)
                                }
                            } else {
                                
                                if response.response?.statusCode == 200 || response.response?.statusCode == 201  {
                                    
                                    completion(createdObjectHref: nil, error: nil, data: resp)
                                    
                                } else {
                                    completion(createdObjectHref: nil, error: response.result.error, data: resp)
                                }
                            }
                        } else {
                            completion(createdObjectHref: nil, error: response.result.error, data: nil)
                        }
                    } else {
                        completion(createdObjectHref: nil, error: response.result.error, data: nil)
                    }
                }
        }
    }
    
    internal func retreiveResourceForUri(url uri: String, completion: (data: JSON, error: NSError?) -> Void) {
        
        self.retreiveResourceForUrl(url: uri, completion: { (data, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                completion(data: data, error: error)
            }
        })
    }
    
    private func retreiveResourceForUrl(url url: String, completion: (data: JSON, error: NSError?) -> Void) {
        
        let URL = NSURL(string: url+Constants.APPID)
        let mutableURLRequest = NSMutableURLRequest(URL: URL!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.GET.rawValue
        mutableURLRequest.timeoutInterval = 60
        let manager = Alamofire.Manager.sharedInstance // or create a new one
        manager.request(mutableURLRequest)
            .response { (request, response, data, error) -> Void in
                if response?.statusCode != 200 {
                    let theError = NSError(domain: "UserServiceManager", code:1, userInfo: [NSLocalizedDescriptionKey:"resource retreive failed for \(url)"])
                    completion(data: nil, error: theError)
                }
            }
            .responseJSON { response -> Void in
                
//                dispatch_async(dispatch_get_main_queue()) {
//                    print("#######################")
//                    print("REQUEST : \(response.request)")
//                    print("#######################")
//                    print("RESPONSE : \(response.response)")
//                    print("#######################")
//                    print("DATA : \(response.result.value)")
//                    print("#######################")
//                    print("ERROR : \(response.result.error)")
//                    print("#######################")
//                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                    
                    if (response.result.error == nil) {
                        if response.response?.statusCode == 200 {
                            
                            if let data :AnyObject = response.result.value {
                                let json = JSON(data)
                                
                                completion(data: json, error: nil)
                                
                            } else {
                                let theError = NSError(domain: "UserServiceManager", code:1, userInfo: [NSLocalizedDescriptionKey:"no JSON for \(url)"])
                                completion(data: nil, error: theError)
                            }
                            
                        } else {
                            let theError = NSError(domain: "UserServiceManager", code:1, userInfo: [NSLocalizedDescriptionKey:"resource retreive failed for \(url)"])
                            completion(data: nil, error: theError)
                        }
                    } else {
                        completion(data: nil, error: response.result.error)
                    }
                }
        }
    }
}