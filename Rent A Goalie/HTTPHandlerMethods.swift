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

enum Handlers {
    case games, goalies, locations, getMostRecentGame, checkForGoalie, none
}

func parseGoalies(json: JSON) {
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
        print(goalie!)
    }
    Shared.shared.goalies = goalies
}

func parseGames(json: JSON) {
    var games = [Game]()
    var count = 0
    while json[count] != JSON.null {
        let game = Game(id: json[count]["id"].intValue, firstName: json[count]["firstName"].stringValue, lastName: json[count]["lastName"].stringValue, skillLevel: json[count]["skillLevel"].intValue, location: json[count]["location"].stringValue, datetime: json[count]["datetime"].stringValue, goaliesNeeded: json[count]["numOfGoalies"].intValue)
        games.append(game!)
        print(game!)
        count += 1
        
    }
    Shared.shared.games = games
}

func getMostRecentGame(json: JSON) {
    Shared.shared.currentGame = json["id"].intValue
    print("Current game is: " + String(describing: json["id"].intValue))
}

func parseLocations(json: JSON) {
    var locations: [String] = [String]()
    var count: Int = 0
    while json[count] != JSON.null {
        let location = json[count]["name"].stringValue
        locations.append(location)
        print(location)
        count += 1
    }
    Shared.shared.locations = locations
}

func checkForGoalie(json: JSON) {
    if (json["goalieOne"] != JSON.null) {
        Shared.shared.foundGoalie = true
    }
}
//
//func parseLights(json: JSON) {
//    var lights = [Light]()
//    var count = 1
//    while json[String(count)] != JSON.null {
//        let light = Light(json: json[String(count)])
//        lights.append(light)
//        count += 1
//    }
//
//    Shared.shared.lights = lights
//}
//
//func parseUsername(json: JSON) {
//    Shared.shared.username = json[0]["success"]["username"].string
//    print(Shared.shared.username)
//}


