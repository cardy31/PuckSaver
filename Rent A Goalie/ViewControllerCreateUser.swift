//
//  ViewControllerCreateUser.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-19.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerCreateUser: UIViewController {
    let api: API = API()
    let parser: JSONParserCustom = JSONParserCustom()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var is_goalie: UISegmentedControl!
    
    let main = DispatchQueue.main
    let background = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        // Check that text fields haven't been left empty
        if (username.text != nil &&
            password.text != nil &&
            email.text != nil &&
            first_name.text != nil &&
            last_name.text != nil)
        {
            let new_user: User = User(id: 0,
                                      username: username.text!,
                                      password: password.text!,
                                      email: email.text!,
                                      first_name: first_name.text!,
                                      last_name: last_name.text!,
                                      is_active: false,
                                      profile: Profile(),
                                      goalie: Goalie(),
                                      token: "")!
            print("Creating user!\n")
            
            api.postUserWithSuperToken(new_user) { responseObject, error in
                if (error == nil) {
                    let user: User = self.parser.parseUser(json: responseObject!)
                    Shared.shared.user = user
                    if (Shared.shared.user.is_goalie == true) {
                        self.background.sync{
                            self.performSegue(withIdentifier: "goalieCreate", sender: self)
                        }
                    }
                    else {
                        print("Not a goalie")
                        self.background.sync{
                            self.performSegue(withIdentifier: "goalieCreate", sender: self)
                        }
                    }
                }
            }
        }
        else {
            // TODO: Highlight fields that aren't good.
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
