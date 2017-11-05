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
    
    @IBOutlet weak var tableView: UITableView!
    var tableDataSource = Shared.shared.games
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\n\n\nNumber of games: " + String(describing:Shared.shared.games.count))
        return Shared.shared.games.count
    }
    
    // create a cell for each table view row
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        // set the text from the data model
        cell.textLabel?.text = Shared.shared.games?[indexPath.row].description
        
        return cell
    }
    
    // method to run when table view cell is tapped
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
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
