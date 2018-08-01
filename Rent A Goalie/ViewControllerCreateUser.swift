//
//  ViewControllerCreateUser.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-19.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerCreateUser: UIViewController {
    let api: API = API()
    let parser: JSONParserCustom = JSONParserCustom()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordAgain: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var is_goalie: UISegmentedControl!
    
    // Labels
    @IBOutlet var usernameValidationLabel: UILabel!
    @IBOutlet var passwordValidationLabel: UILabel!
    @IBOutlet var passwordAgainValidationLabel: UILabel!
    @IBOutlet var emailValidationLabel: UILabel!
    @IBOutlet var firstNameValidationLabel: UILabel!
    @IBOutlet var lastNameValidationLabel: UILabel!

    // Store new user after creation but before segue
    var user_id: Int = 0

    // Queues
    let background = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Close keyboard by tapping anywhere
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        setupView()
    }
    
    fileprivate func setupView() {
        // Configure Password Validation Label
        usernameValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        passwordAgainValidationLabel.isHidden = true
        emailValidationLabel.isHidden = true
        firstNameValidationLabel.isHidden = true
        lastNameValidationLabel.isHidden = true

        // This needs to happen for the keyboard to switch when a user hits enter
        username.delegate = self
        password.delegate = self
        passwordAgain.delegate = self
        email.delegate = self
        first_name.delegate = self
        last_name.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Validation functions
    func isEmpty(_ textField: UITextField, label: UILabel) -> Bool{
        guard let text = textField.text else {
            assert(false)
        }

        if text.count > 0 {
            if label.isHidden == false {
                UIView.animate(withDuration: 0.25, animations: {
                    label.isHidden = true
                })
            }
            return false
        }
        else {
            label.text = "Field cannot be empty"
            UIView.animate(withDuration: 0.25, animations: {
                label.isHidden = false
            })
        }

        return true
    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: testStr) == false {
            self.emailValidationLabel.text = "Please enter a valid email"
            UIView.animate(withDuration: 0.25, animations: {
                self.emailValidationLabel.isHidden = false
            })
            return false
        }
        else {
            if self.emailValidationLabel.isHidden == false {
                UIView.animate(withDuration: 0.25, animations: {
                    self.emailValidationLabel.isHidden = true
                })
            }
            return true
        }
    }

    func checkUnique(_ textField: UITextField) {
        guard let text = textField.text else {
            assert(false)
        }
        
        if textField == username {
            api.uniqueUsername(text) { responseObject, error in
                if (error == nil) {
                    // Username is not unique
                    if self.parser.parseUnique(json: responseObject!) == false {
                        print("Username is taken")
                        UIView.animate(withDuration: 0.25, animations: {
                            self.usernameValidationLabel.isHidden = false
                            self.usernameValidationLabel.text = "Sorry, that username is taken"
                        })
                        self.username.becomeFirstResponder()
                    }
                    // Username is unique
                    else {
                        UIView.animate(withDuration: 0.25, animations: {
                            if self.usernameValidationLabel.isHidden == false {
                                self.usernameValidationLabel.text = "Username is available"
                            }
                        })
                    }
                }
                else {
                    print("Error in checking if username is unique: " + error.debugDescription)
                    assert(false)
                }
            }
        }
        else if textField == email {
            api.uniqueEmail(text) { responseObject, error in
                if (error == nil) {
                    // Email is not unique
                    if self.parser.parseUnique(json: responseObject!) == false {
                        print("Email is already taken")
                        UIView.animate(withDuration: 0.25, animations: {
                            self.emailValidationLabel.isHidden = false
                            self.emailValidationLabel.text = "Sorry, that email is taken"
                        })
                        self.email.becomeFirstResponder()
                    }
                    // Email is unique
                    else {
                        UIView.animate(withDuration: 0.25, animations: {
                            if self.emailValidationLabel.isHidden == false {
                                self.emailValidationLabel.text = "Email is available"
                            }
                        })
                    }
                }
                else {
                    print("Error in checking if email is unique: " + error.debugDescription)
                    assert(false)
                }
            }
        }
        else {
            print("checkUnique was passed an unsupported textField.")
            assert(false)
        }
    }

    fileprivate func validatePassword(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            assert(false)
        }

        if text.count < 8 {
            print("Password is too short")
            return (false, "Your password is too short.")
        }

        if text.count == 0 {
            print("Password field is empty")
            return (false, "This field cannot be empty.")
        }

        return (true, "")
    }

    fileprivate func validatePasswordAgain(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            assert(false)
        }

        let (valid, message) = validatePassword(textField)
        if valid == false {
            print("validatePasswordAgain basic check failed")
            return (valid, message)
        }

        if text != password.text {
            print("validatePasswordAgain passwords don't match")
            return (false, "Passwords do not match")
        }
        print("validatePasswordAgain return true")
        return(true, "")
    }

    fileprivate func validateName(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            assert(false)
        }

        if text.count > 0 && text.count < 30 {
            return (true, "")
        }
        else if text.count == 0 {
            return (false, "Field cannot be empty.")
        }
        else {
            return (false, "This should be less than 30 characters. Currently: " + String(describing: text.count))
        }
    }


    // Submit Form Data
    @IBAction func submit(_ sender: Any) {
        // Check that text fields haven't been left empty
        if (username.text != nil &&
            password.text != nil &&
            email.text != nil &&
            first_name.text != nil &&
            last_name.text != nil)
        {
            // Convert the selected segment index to a Bool
            let is_goalie_num: Int = self.is_goalie.selectedSegmentIndex
            var is_goalie_bool: Bool
            if is_goalie_num == 0 {
                is_goalie_bool = true
            }
            else {
                is_goalie_bool = false
            }

            let new_user: UserCreate = UserCreate(username: username.text!,
                                            password: password.text!,
                                            email: email.text!,
                                            first_name: first_name.text!,
                                            last_name: last_name.text!,
                                            is_goalie: is_goalie_bool
            )!

            api.createUser(new_user) { responseObject, error in
                if error == nil {
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let user = User(context: context)
                    let profile = Profile(context: context)
                    let goalie = Goalie(context: context)
                    
                    user.user_to_profile = profile
                    user.user_to_goalie = goalie

                    var result: Bool
                    (result, self.user_id) = self.parser.parseUser(json: responseObject!, user: user, profile: profile)
                    if result == false {
                        print("JSON Parsing failed for user")
                        assert(false)
                    }
                    // User is a goalie
                    if self.is_goalie.selectedSegmentIndex == 0 {
                        if self.parser.parseGoalieFromUser(json: responseObject!, goalie: goalie) == false {
                            print("JSON parsing failed for goalie")
                            assert(false)
                        }
                    }
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()

                    self.background.sync{
                        self.performSegue(withIdentifier: "verifyEmail", sender: self)
                    }
                }
            }
        }
//        else {
//            // TODO: Highlight fields that aren't good.
//        }
    }




    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewControllerValidateEmail {
            let vc = segue.destination as? ViewControllerValidateEmail
            vc?.id = self.user_id
        }
    }
    

}
extension ViewControllerCreateUser: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case username:
            if self.isEmpty(username, label: usernameValidationLabel) == false {
                self.checkUnique(textField)
                password.becomeFirstResponder()
            }


        case password:
            // Validate Text Field
            let (valid, message) = validatePassword(textField)
            
            if valid {
                if passwordValidationLabel.isHidden == false {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.passwordValidationLabel.isHidden = true
                    })
                }
                passwordAgain.becomeFirstResponder()
            }
            else {
                // Update Password Validation Label
                self.passwordValidationLabel.text = message

                // Show/Hide Password Validation Label
                UIView.animate(withDuration: 0.25, animations: {
                    self.passwordValidationLabel.isHidden = false
                })
            }

        case passwordAgain:
            let (valid, message) = validatePasswordAgain(textField)

            if valid {
                if passwordAgainValidationLabel.isHidden == false {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.passwordAgainValidationLabel.isHidden = true
                    })
                }
                email.becomeFirstResponder()
            }
            else {
                // Update Password Validation Label
                self.passwordAgainValidationLabel.text = message

                // Show/Hide Password Validation Label
                UIView.animate(withDuration: 0.25, animations: {
                    self.passwordAgainValidationLabel.isHidden = false
                })
            }


        case email:
            if self.isEmpty(email, label: emailValidationLabel) == false &&
                            self.isValidEmail(testStr: textField.text!) {
                self.checkUnique(textField)
                first_name.becomeFirstResponder()
            }

        case first_name:
            let (valid, message) = self.validateName(textField)

            if valid {
                // Hide label if it isn't hidden
                if firstNameValidationLabel.isHidden == false {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.firstNameValidationLabel.isHidden = true
                    })
                }
                last_name.becomeFirstResponder()
            }
            else {
                UIView.animate(withDuration: 0.25, animations: {
                    self.firstNameValidationLabel.isHidden = false
                    self.firstNameValidationLabel.text = message
                })
            }

        case last_name:
            let (valid, message) = self.validateName(textField)

            if valid {
                // Hide label if it isn't hidden
                if lastNameValidationLabel.isHidden == false {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.lastNameValidationLabel.isHidden = true
                    })
                }
            }
            else {
                UIView.animate(withDuration: 0.25, animations: {
                    self.lastNameValidationLabel.isHidden = false
                    self.lastNameValidationLabel.text = message
                })
            }


        default:
            email.resignFirstResponder()
        }
        
        return true
    }
}



