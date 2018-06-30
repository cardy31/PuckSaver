//
//  ViewControllerWaitingForGoalie.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-05.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerWaitingForGoalie: UIViewController {
    
    let api = API()
    let parser = JSONParserCustom()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func refresh(_ sender: Any) {
        checkGame()
        if (Shared.shared.foundGoalie) {
            performSegue(withIdentifier: "foundGoalie", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkGame() {
        // TODO: Get rid of the shared value
        let url: String = "http://robcardy.com/game/" + String(describing: Int(Shared.shared.currentGame)) + "/"
        print("\n\n\nURL is: " + url)
        api.getGame(Shared.shared.currentGame) { responseObject, error in
            let game: Game = self.parser.parseGame(json: responseObject!)
            if game.goaliesNeeded == 1 {
                if game.goalieOne != "null" {
                    self.performSegue(withIdentifier: "foundGoalie", sender: self)
                }
            }
            else { // 2 goalies needed
                if game.goalieOne != "null" && game.goalieTwo != "null" {
                    self.performSegue(withIdentifier: "foundGoalie", sender: self)
                }
            }
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
