//
//  ViewControllerAvailableGames.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerAvailableGames: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellReuseIdentifier = "cell"
    var games: [Game] = []
    
    let api = API()
    let parser = JSONParserCustom()
    
    @IBOutlet weak var tableView: UITableView!
    var tableDataSource = Shared.shared.games
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table view stuff
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get the data we need
        api.getGames() { responseObject, error in
            self.games = self.parser.parseGames(json: responseObject!)
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\n\n\nNumber of games: " + String(describing:games.count))
        return games.count
    }
    
    // create a cell for each table view row
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        // set the text from the data model
        cell.textLabel?.text = games[indexPath.row].description
        
        return cell
    }
    
    // method to run when table view cell is tapped
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = "http://robcardy.com/game/" + String(describing:(indexPath.row + 2)) + "/"
        let num = Shared.shared.signedInGoalie.id
        // TODO: This should be a patch operation
//        api.httpPUT(url: url, handler: Handlers.none, parameters: [
//            "goalieOne": "http://robcardy.com/goalie/" + String(describing: num) + "/",
//            "firstName": Shared.shared.signedInGoalie.firstName,
//            "lastName": Shared.shared.signedInGoalie.lastName,
//            "location": Shared.shared.signedInGoalie.cities[0]
//            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
