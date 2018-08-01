//
// Created by Rob Cardy on 2018-07-29.
// Copyright (c) 2018 Cardy Inc. All rights reserved.
//

import Foundation

class UserCreate: CustomStringConvertible {
    // MARK: Properties
    var username: String
    var password: String
    var email: String
    var first_name: String
    var last_name: String
    var is_goalie: Bool

    // MARK: Initialization
    init?(username: String, password: String, email: String, first_name: String, last_name: String, is_goalie: Bool) {
        self.username = username
        self.password = password
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.is_goalie = is_goalie
    }

    // MARK: Methods
    func toJson() -> [String: Any] {
        let value: [String: Any] = [ "username": self.username,
                 "password": self.password,
                 "email": self.email,
                 "first_name": self.first_name,
                 "last_name": self.last_name,
                 "is_goalie": self.is_goalie ? "true": "false" ]

        print("Converting UserCreate object to json. Result:")
        print(value)
        return value
    }

    public var description: String {
        return self.username
    }
}