//
//  User.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-19.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

//import Foundation

//class User: CustomStringConvertible {
//    // MARK: Properties
//    var id: Int
//    var username: String
//    var email: String
//    var first_name: String
//    var last_name: String
//    var is_staff: Bool
//    var is_active: Bool
//    var profile: Profile
//    var goalie: Goalie
//    var token: String = ""
//
//    // MARK: Initialization
//    init(id: Int, username: String, email: String, first_name: String, last_name: String,
//         is_staff: Bool, is_active: Bool, profile: Profile, goalie: Goalie, token: String) {
//        self.id = id
//        self.username = username
//        self.email = email
//        self.first_name = first_name
//        self.last_name = last_name
//        self.is_staff = is_staff
//        self.is_active = is_active
//        self.profile = profile
//        self.goalie = goalie
//        self.token = token
//    }
//
//    convenience init() {
//        self.init(id: 0,
//                username: "",
//                email: "",
//                first_name: "",
//                last_name: "",
//                is_staff: false,
//                is_active: false,
//                profile: Profile(),
//                goalie: Goalie(),
//                token: "")
//    }
//
//    // MARK: Methods
//    func toJson() -> [String: Any] {
//        return ["id": self.id,
//                "username": self.username,
//                "email": self.email,
//                "first_name": self.first_name,
//                "last_name": self.last_name,
//                "is_staff": self.is_staff,
//                "is_active": self.is_active,
//                "profile": self.profile.toJson(),
//                "goalie": self.goalie.toJson(),
//                "token": self.token]
//
//    }
//
//    public var description: String {
//        return self.username
//    }
//}
