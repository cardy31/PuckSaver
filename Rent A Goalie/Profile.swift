//
//  Profile.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2018-06-28.
//  Copyright © 2018 Cardy Inc. All rights reserved.
//

import Foundation

class Profile: CustomStringConvertible {
    var id: Int
    var is_goalie: Bool
    var rating: Int
    var games_played: Int
    var reset_token: String
    var picture: String


    init(id: Int, is_goalie: Bool, rating: Int, games_played: Int, reset_token: String, picture: String) {
        self.id = id
        self.is_goalie = is_goalie
        self.rating = rating
        self.games_played = games_played
        self.reset_token = reset_token
        self.picture = picture
    }
    
    convenience init() {
        self.init(id: 0, is_goalie: false, rating: 1, games_played: 0, reset_token: "", picture: "")
    }

    func toJson() -> [String: Any] {
        return ["id": self.id,
                "is_goalie": self.is_goalie,
                "rating": self.rating,
                "games_played": self.games_played,
                "reset_token": self.reset_token,
                "picture": self.picture]
    }

    public var description: String {
        return "ID: " + String(describing: self.id)
    }
}
