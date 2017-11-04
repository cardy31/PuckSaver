//
//  Shared.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import Foundation

/*
 * This class is used for sharing information between views.
 */
final class Shared {
    static let shared = Shared() //lazy init, and it only runs once
    
    var goalies : [Goalie]!
    var games : [Game]!
    var locations: [String]!
}
