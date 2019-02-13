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
    let apiUrl: String = "https://robcardy.com/api/"
    let apiCreationToken: String = "cbba7a977b3167ad8cf1115f54ff7212106ad479"
    
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
    
    func getUsers(completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpGET("user/", completionHandler: completionHandler)
    }
    
    func getUser(_ userId: Int, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let urlExtention: String = "user/" + String(describing: userId) + "/"
        httpGET(urlExtention, completionHandler: completionHandler)
    }
    
    // Taken from: https://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
    private func httpGET(_ urlExtension: String, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
        // TODO: Add auth header
        let headers: [String: String] = ["Authorization": "Token cbba7a977b3167ad8cf1115f54ff7212106ad479"]
        Alamofire.request(url, headers: headers).responseJSON { response in
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
    
    // POST Methods - Used to create or update an entire entry
//    func postGoalie(_ goalie: Goalie, completionHandler: @escaping (JSON?, Error?) -> ()) {
//        httpPOST("goalie/", goalie.toJson(), completionHandler: completionHandler)
//    }
    
    func postGame(_ game: Game, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPOST("game/", game.convertForPost(), completionHandler: completionHandler)
    }
    
    func postLocation(_ name: String, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPOST("location/", ["name": name], completionHandler: completionHandler)
    }
    
//    func postUser(_ user: User, completionHandler: @escaping (JSON?, Error?) -> ()) {
//        httpPOST("user-create/", user.toJson(), completionHandler: completionHandler)
//    }
    
    func httpPOST(_ urlExtension: String, _ parameters: [String: Any], completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
//        let method: HTTPMethod = .post
//        let encoding: JSONEncoding = JSONEncoding.default
        let headers: [String: String] = ["Authorization":"Token cbba7a977b3167ad8cf1115f54ff7212106ad479"]

        print("Alamofire is posting...")
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            // Print some info about the HTTP request
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Response: \(String(describing: response.debugDescription))") // http url response
            switch response.result {
                case .success(let value):
                    print("Success")
                    print(response.response!.statusCode)
                    completionHandler(JSON(value), nil)
                case .failure(let error):
                    print("Failure")
                    print(response.response!.statusCode)
                    completionHandler(nil, error)
            }
        }
    }

    func createUser(_ user: UserCreate, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPostWithToken("user-create/", user.toJson(), completionHandler: completionHandler)
    }

    // Check user fields
    func uniqueUsername(_ username: String, completionHandler: @escaping (JSON?, Error?) -> ()) {
        print("API Making post request")
        httpPOST("check-username/", ["username": username], completionHandler: completionHandler)
    }

    func uniqueEmail(_ email: String, completionHandler: @escaping (JSON?, Error?) -> ()) {
        httpPOST("check-email/", ["email": email], completionHandler: completionHandler)
    }



    func httpUsernameTokenPOST(_ urlExtension: String, _ parameters: [String: String], completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
        let method: HTTPMethod = .post
        let encoding: JSONEncoding = JSONEncoding.default
        let headers: [String: String] = ["Content-Type":"application/json", "Authorization": "Token 61475e173b7f21773f5c306dbe6e8443d00136ba"]

        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
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



    func httpPostWithToken(_ urlExtension: String, _ parameters: [String: Any], completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
//        let method: HTTPMethod = .post
//        let encoding: JSONEncoding = JSONEncoding.default
        let headers: [String: String] = ["Authorization":"Token cbba7a977b3167ad8cf1115f54ff7212106ad479"]

        print("Alamofire is posting...")

        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            // Print some info about the HTTP request
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Response: \(String(describing: response.debugDescription))") // http url response
            switch response.result {
            case .success(let value):
                print("Success")
                print(response.response!.statusCode)
                completionHandler(JSON(value), nil)
            case .failure(let error):
                print("Failure")
                print(response.response!.statusCode)
                completionHandler(nil, error)
            }
        }
    }
    
    // PATCH Methods - These can be used to change one field in an entry
    func patchGoalie(_ goalieId: Int, _ key: String, _ value: Any, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let urlExtension = "goalie/" + String(describing: goalieId) + "/"
        let parameter: [String: Any] = [key: value]
        httpPATCH(urlExtension, parameter, completionHandler: completionHandler)
    }
    
    func patchGame(_ gameId: Int, _ key: String, _ value: Any, completionHandler: @escaping (JSON?, Error?) -> ()) {
        let urlExtension = "game/" + String(describing: gameId) + "/"
        let parameter: [String: Any] = [key: value]
        httpPATCH(urlExtension, parameter, completionHandler: completionHandler)
    }
    
    private func httpPATCH(_ urlExtension: String, _ parameter: [String: Any], completionHandler: @escaping (JSON?, Error?) -> ()) {
        let url: String = apiUrl + urlExtension
        let method: HTTPMethod = .patch
        let encoding: JSONEncoding = JSONEncoding.default
        let headers: [String: String] = ["Content-Type":"application/json"] // TODO: Add auth header
        
        Alamofire.request(url, method: method, parameters: parameter, encoding: encoding, headers: headers)
    }
}
