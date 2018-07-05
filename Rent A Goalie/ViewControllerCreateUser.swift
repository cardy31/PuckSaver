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
    
    // Labels
    @IBOutlet var usernameValidationLabel: UILabel!
    @IBOutlet var passwordValidationLabel: UILabel!
    @IBOutlet var emailValidationLabel: UILabel!
    
    let main = DispatchQueue.main
    let background = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    fileprivate func setupView() {
        // Configure Password Validation Label
        usernameValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        emailValidationLabel.isHidden = true

        // This needs to happen for the keyboard to switch when a user hits enter
        username.delegate = self
        password.delegate = self
        email.delegate = self
        first_name.delegate = self
        last_name.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func checkUnique(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }

        var returnValue: Bool = false
        if textField == username {
            api.uniqueUsername(text) { responseObject, error in
                if (error == nil) {
                    returnValue = self.parser.parseUnique(json: responseObject!)
                }
            }
            if (returnValue == false) {
                return (returnValue, "Sorry, this username is already taken.")
            }
            return (returnValue, nil)
        }

        if textField == email {
            api.uniqueEmail(text) { responseObject, error in
                if (error == nil) {
                    returnValue = self.parser.parseUnique(json: responseObject!)
                }
            }
            if (returnValue == false) {
                return (returnValue, "Sorry, this email is already in use.")
            }
            return (returnValue, nil)
        }

        return (false, nil)
    }


    fileprivate func validatePassword(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }

        if textField == password {
            return (text.count >= 6, "Your password is too short.")
        }

        return (text.count > 0, "This field cannot be empty.")
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

            var unique: Bool = false

            api.uniqueUsername(username.text!) { responseObject, error in
                if (error == nil) {
                    let json = responseObject!
                    print("CARDY Here")
                    print(json["unique"])
                }
                unique = false
            }





//            api.postUserWithSuperToken(new_user) { responseObject, error in
//                if (error == nil) {
//                    let user: User = self.parser.parseUser(json: responseObject!)
//                    Shared.shared.user = user
//                    if (Shared.shared.user.profile.is_goalie == true) {
//                        self.background.sync{
//                            self.performSegue(withIdentifier: "goalieCreate", sender: self)
//                        }
//                    }
//                    else {
//                        print("Not a goalie")
//                        self.background.sync{
//                            self.performSegue(withIdentifier: "goalieCreate", sender: self)
//                        }
//                    }
//                }
//            }
        }
//        else {
//            // TODO: Highlight fields that aren't good.
//        }
    }




    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
extension ViewControllerCreateUser: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case username:
            // Check that username is unique
            let (valid, message) = self.checkUnique(textField)
            
            if valid {
                password.becomeFirstResponder()
            }

            self.usernameValidationLabel.text = message

            UIView.animate(withDuration: 0.25, animations: {
                self.usernameValidationLabel.isHidden = valid
            })

        case password:
            // Validate Text Field
            let (valid, message) = validatePassword(textField)
            
            if valid {
                email.becomeFirstResponder()
            }
            
            // Update Password Validation Label
            self.passwordValidationLabel.text = message
            
            // Show/Hide Password Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.passwordValidationLabel.isHidden = valid
            })
        case email:
            let (valid, message) = self.checkUnique(textField)

            if valid {
                first_name.becomeFirstResponder()
            }

            self.emailValidationLabel.text = message

            UIView.animate(withDuration: 0.25, animations: {
                self.emailValidationLabel.isHidden = valid
            })

        case first_name:
            last_name.becomeFirstResponder()

        default:
            email.resignFirstResponder()
        }
        
        return true
    }
}



