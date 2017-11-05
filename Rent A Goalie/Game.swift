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
    
    init?(id: Int, firstName: String, lastName: String, skillLevel: Int, location: String, datetime: String, goaliesNeeded: Int) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.location = location
        self.datetime = datetime
        self.goaliesNeeded = goaliesNeeded
    }
    
    public var description: String {
        return firstName + "'s Game"
    }
}
