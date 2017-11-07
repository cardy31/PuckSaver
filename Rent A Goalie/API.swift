//
//  API.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-06.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    // The root directory of the API
    let apiUrl: String = "http://robcardy.com/"
    
    // GET Methods
    func getGoalies(completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpGET("goalie/", completionHandler: completionHandler)
    }
    
    func getGoalie(_ goalieId: Int, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let urlExtension: String = "goalie/" + String(describing: goalieId) + "/"
        httpGET(urlExtension, completionHandler: completionHandler)
    }
    
    func getGames(completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpGET("game/", completionHandler: completionHandler)
    }
    
    func getGame(_ gameId: Int, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let urlExtension: String = "game/" + String(describing: gameId) + "/"
        httpGET(urlExtension, completionHandler: completionHandler)
    }
    
    func getLocations(completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpGET("location/", completionHandler: completionHandler)
    }
    
    func getLocation(_ locationId: Int, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let urlExtension: String = "location/" + String(describing: locationId) + "/"
        httpGET(urlExtension, completionHandler: completionHandler)
    }
    
    // Taken from: https://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
    private func httpGET(_ urlExtension: String, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
        Alamofire.request(url)
            .responseJSON { response in
                // Print some info about the HTTP request
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                switch response.result {
                case .success(let value):
                    completionHandler(JSON(value), nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
    // POST Methods
    func postGoalie(_ goalie: Goalie, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPOST("goalie/", goalie.convertForPost(), completionHandler: completionHandler)
    }
    
    func postGame(_ game: Game, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPOST("game/", game.convertForPost(), completionHandler: completionHandler)
    }
    
    func postLocation(_ name: String, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPOST("location/", ["name": name], completionHandler: completionHandler)
    }
    
    private func httpPOST(_ urlExtension: String, _ parameters: [String: Any], completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
        let method: HTTPMethod = .post
        let encoding: JSONEncoding = JSONEncoding.default
        let headers: [String: String] = ["Content-Type":"application/json"]
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    // PATCH Methods - These can be used to change one field in an entry
    
    // TODO: Create these
}
