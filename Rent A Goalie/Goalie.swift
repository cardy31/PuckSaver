//
//  Goalie.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

//import Foundation
//
//class Goalie: CustomStringConvertible {
//    // MARK: Properties
//    var id: Int
//    var skill_level: Int
//    var locations: [String]
//
//
//    // MARK: Initialization
//    init(id: Int, skill_level: Int, locations: [String]) {
//        self.id = id
//        self.skill_level = skill_level
//        self.locations = locations // TODO: Convert location urls into city names with HTTP call
//    }
//
//    convenience init() {
//        self.init(id: 0, skill_level: 1, locations: [])
//    }
//
//    // MARK: Methods
//    func toJson() -> [String: Any] {
//        return ["skill_level": self.skill_level, "locations": []]
//    }
//
//    public var description: String {
//        return "ID: " + String(describing: self.id)
//    }
//}
