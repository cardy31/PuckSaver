//
//  ViewControllerValidateEmail.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2018-07-30.
//  Copyright © 2018 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerValidateEmail: UIViewController {

    var id: Int?
    var is_goalie: Bool?
    
    let api: API = API()
    let parser: JSONParserCustom = JSONParserCustom()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reloadView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewControllerValidateEmail.reloadView), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func reloadView() {
        print("Id is:")
        print(self.id!)

        api.getUser(self.id!) { responseObject, error in
            if error == nil {
                self.is_goalie = self.parser.userIsGoalie(json: responseObject!)
                if self.parser.userIsActive(json: responseObject!) {
                    if self.is_goalie! {
                        DispatchQueue.global().sync{
                            self.performSegue(withIdentifier: "goalieCreate", sender: self)
                        }
                    }
                    else {
                        DispatchQueue.global().sync{
                            self.performSegue(withIdentifier: "gameCreate", sender: self)
                        }
                    }

                }
            }
        }
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
