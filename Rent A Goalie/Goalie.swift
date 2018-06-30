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
    var skillLevel: Int
    var locations: [String]
    
    
    //MARK: Initialization
    init(id: Int, skillLevel: Int, locations: [String]) {
        self.id = id
        self.skillLevel = skillLevel
        self.locations = locations // TODO: Convert location urls into city names with HTTP call
    }
    
    convenience init() {
        self.init(id: 0, skillLevel: 1, locations: [])
    }
    
    // MARK: Methods
    func toJson() -> [String: Any] {
        return ["skillLevel": self.skillLevel, "locations": self.locations]
    }
    
    public var description: String {
        return "ID: " + String(describing: self.id)
    }
}
