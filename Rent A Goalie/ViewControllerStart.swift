//
//  ViewController.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerStart: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocations()
        getGames()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getLocations() {
        let url = "http://robcardy.com/location/"
        httpGET(url: url, handler: Handlers.locations)
    }
    
    func getGames() {
        let url = "http://robcardy.com/game/"
        httpGET(url: url, handler: Handlers.games)
    }
    @IBAction func goalieView(_ sender: Any) {
        performSegue(withIdentifier: "goalieSignup", sender: self)
    }
    
}

