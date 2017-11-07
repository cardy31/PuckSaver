//
//  Game.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import Foundation

class Game: CustomStringConvertible {
    var id: Int
    var firstName: String
    var lastName: String
    var skillLevel: Int
    var location: String
    var datetime: String
    var goaliesNeeded: Int
    var goalieOne: String
    var goalieTwo: String
    
    init?(id: Int, firstName: String, lastName: String, skillLevel: Int, location: String, datetime: String, goaliesNeeded: Int, goalieOne: String, goalieTwo: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.location = location
        self.datetime = datetime
        self.goaliesNeeded = goaliesNeeded
        self.goalieOne = goalieOne
        self.goalieTwo = goalieTwo
    }
    
    func convertForPost() -> [String: Any] {
        return ["firstName": firstName, "lastName": lastName, "skillLevel": skillLevel, "location": location, "datetime": datetime, "goaliesNeeded": goaliesNeeded, "goalieOne": goalieOne, "goalieTwo": goalieTwo]
    }
    
    public var description: String {
        return firstName + "'s Game"
    }
}
