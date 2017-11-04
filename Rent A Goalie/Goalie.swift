//
//  Goalie.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import Foundation

class Goalie: CustomStringConvertible {
    // MARK: Properties
    var id: Int
    var firstName: String
    var lastName: String
    var skillLevel: Int
    var cities: [String]
    var pic: String
    
    //MARK: Initialization
    init?(id: Int, firstName: String, lastName: String, skillLevel: Int, cities: [String], pic: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.cities = cities // TODO: Convert location urls into city names with HTTP call
        self.pic = pic
    }
    
    // MARK: Methods
    public var description: String {
        return "Name is " + self.firstName + " " + self.lastName + "\nSkill Level is " + String(describing: self.skillLevel) +
            "\nID is " + String(describing: self.id) + "\nCities are " + String(describing: self.cities) + "\n"
    }
}
