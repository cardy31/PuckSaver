//
//  HTTPRequestMethods.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

func httpGET(url: String, handler: Handlers) {
    Alamofire.request(url).responseJSON { response in
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result
        
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            switch handler {
            case .goalies:
                parseGoalies(json: json)
            case .games:
                parseGames(json: json)
            case .locations:
                parseLocations(json: json)
            case .checkForGoalie:
                checkForGoalie(json: json)
            default:
                print("Invalid option selected")
            }
        case .failure(let error):
            print(error)
        }
    }
}

func httpPOST(url: String, handler: Handlers, parameters: [String: Any]) {
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON { response in
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result
        
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            switch handler {
            case .goalies:
                print("Placeholder")
            case .getMostRecentGame:
                getMostRecentGame(json: json)
            case .none:
                print("None")
            default:
                print("Invalid handler")
            }
        case .failure(let value):
            print(JSON(value)[0])
        }
    }
}

func httpPUT(url: String, handler: Handlers, parameters: [String: Any]) {
    Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result

        switch response.result {
        case .success(let value):
            print("PUT was successful! Info: ")
            print(value)
        case .failure(let error):
            print(error)
        }
    }
}

