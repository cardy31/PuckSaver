//
//  HTTPHandlerMethods.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class JSONParserCustom {
    
    // TODO: Write singular functions (game, goalie, location)
    func parseGames(json: JSON) -> [Game] {
        var games = [Game]()
        var count = 0
        while json[count] != JSON.null {
            let game = parseGame(json: json[count])
            games.append(game)
            print(game)
            count += 1
        }
        return games
    }
    
    func parseGame(json: JSON) -> Game {
        let game = Game(id: json["id"].intValue, firstName: json["firstName"].stringValue, lastName: json["lastName"].stringValue, skillLevel: json["skillLevel"].intValue, location: json["location"].stringValue, datetime: json["datetime"].stringValue, goaliesNeeded: json["numOfGoalies"].intValue, goalieOne: json["goalieOne"].stringValue, goalieTwo: json["goalieTwo"].stringValue)
        return game!
    }
    
    func parseGoalies(json: JSON) -> [Goalie] {
        var goalies = [Goalie]()
        var count: Int = 0
        while json[count] != JSON.null {
            var locations: [String] = []
            var count2: Int = 0
            while json[count]["locations"][count2] != JSON.null {
                locations.append(json[count]["locations"][count2].stringValue)
                count2 += 1
            }
            let goalie = Goalie(id: json[count]["id"].intValue, skillLevel: json[count]["skillLevel"].intValue, locations: locations)
            goalies.append(goalie)
            count += 1
        }
        return goalies
    }
    
    func parseLocations(json: JSON) -> [String] {
        var locations: [String] = [String]()
        var count: Int = 0
        while json[count] != JSON.null {
            let location = json[count]["name"].stringValue
            locations.append(location)
            print(location)
            count += 1
        }
        return locations
    }
    
    func parseUser(json: JSON) -> User {
        return User(id: json["id"].intValue, username: json["username"].stringValue, password: "", email: json["email"].stringValue, first_name: json["first_name"].stringValue, last_name: json["last_name"].stringValue, is_active: json["is_active"].boolValue, profile: Profile(), goalie: Goalie(), token: "")!
    }

    func parseUnique(json: JSON) -> Bool {
        return json["unique"].boolValue
    }

}
