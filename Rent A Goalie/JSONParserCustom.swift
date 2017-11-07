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
    
    func parseGames(json: JSON) -> [Game]{
        var games = [Game]()
        var count = 0
        while json[count] != JSON.null {
            let game = Game(id: json[count]["id"].intValue, firstName: json[count]["firstName"].stringValue, lastName: json[count]["lastName"].stringValue, skillLevel: json[count]["skillLevel"].intValue, location: json[count]["location"].stringValue, datetime: json[count]["datetime"].stringValue, goaliesNeeded: json[count]["numOfGoalies"].intValue, goalieOne: json[count]["goalieOne"].stringValue, goalieTwo: json[count]["goalieTwo"].stringValue)
            games.append(game!)
            print(game!)
            count += 1
            
        }
        return games
    }
    
    func parseGoalies(json: JSON) -> [Goalie]{
        var goalies = [Goalie]()
        var count: Int = 0
        while json[count] != JSON.null {
            var cities: [String] = []
            var count2: Int = 0
            while json[count]["cities"][count2] != JSON.null {
                cities.append(json[count]["cities"][count2].stringValue)
                count2 += 1
            }
            let goalie = Goalie(id: json[count]["id"].intValue, firstName: json[count]["firstName"].stringValue, lastName: json[count]["lastName"].stringValue, skillLevel: json[count]["skillLevel"].intValue, cities: cities, pic: json[count]["pic"].stringValue)
            goalies.append(goalie!)
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
}
