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

/* {
    "id": 50,
    "username": "robTester909",
    "email": "rob.cardy.31@gmail.com",
    "first_name": "Steve",
    "last_name": "Tester",
    "is_staff": false,
    "is_active": false,
    "profile": {
        "id": 50,
        "is_goalie": true,
        "rating": 0,
        "games_played": 0,
        "reset_token": "4yb-9b4225fc9368756e07c6",
        "picture": null
    },
    "goalie": {
        "id": 50,
        "skill_level": 5,
        "location_ids": []
    },
    "token": "5e79ce01853fb8d70a4e01cf3050127c0e7f0ffa"
} */
    func parseUser(json: JSON, user: User, profile: Profile) -> (Bool, Int) {
        // User
        user.id = Int32(json["id"].intValue)
        user.username = json["username"].stringValue
        user.email = json["username"].stringValue
        user.first_name = json["first_name"].stringValue
        user.last_name = json["last_name"].stringValue
        user.is_staff = json["is_staff"].boolValue
        user.is_active = json["is_active"].boolValue

        // Profile
        profile.id = Int32(json["profile"]["id"].intValue)
        profile.is_goalie = json["profile"]["is_goalie"].boolValue
        profile.rating = json["profile"]["rating"].doubleValue
        profile.games_played = Int32(json["profile"]["games_played"].intValue)
        profile.reset_token = json["profile"]["reset_token"].stringValue
        profile.picture = json["profile"]["picture"].stringValue
        
        // Token
        user.token = json["token"].stringValue
        
        return (true, json["id"].intValue)
    }

    func parseGoalieFromUser(json: JSON, goalie: Goalie) -> Bool {
        // Goalie
        goalie.id = Int32(json["goalie"]["id"].intValue)
        goalie.skill_level = Int16(json["goalie"]["skill_level"].intValue)

        return true
    }

    func userIsActive(json: JSON) -> Bool {
        print("In function userIsActive")
        print(json)
        print(json["is_active"])
        return json["is_active"].boolValue
    }

    func userIsGoalie(json: JSON) -> Bool {
        print("In function userIsGoalie")
        print(json)
        print(json["profile"]["is_goalie"])
        return json["profile"]["is_goalie"].boolValue
    }

    func parseUnique(json: JSON) -> Bool {
        return json["unique"].stringValue == "true"
    }
}
