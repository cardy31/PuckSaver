//
//  ViewControllerGoalieSignupViewController.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

// This is for hiding the keyboard on a screen tap
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class ViewControllerGoalieSignup: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let api = API()
    let parser = JSONParserCustom()

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var skillLevel: UISegmentedControl!
    @IBOutlet weak var cityPicker: UIPickerView!
    var pickerDataSource: [String] = []
    var selectedValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        cityPicker.dataSource = self
        cityPicker.delegate = self
        api.getLocations() { responseObject, error in
            if error == nil {
//                self.pickerDataSource = self.parser.parseLocations(json: responseObject!)
                self.cityPicker.reloadAllComponents()
            }
            else {
                print("Error was returned as non- nil. Error: " + String(describing: error!))
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = row
    }
    
    func getSegment() -> Int {
        switch skillLevel.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 4
        case 4:
            return 5
        default:
            return 0
        }
    }
    
    @IBAction func submit(_ sender: Any) {
//        let api = API()
//        let goalie = Goalie(id: 0, skill_level: getSegment(), locations: [])
//        // TODO: Handle error
//        api.postGoalie(goalie) { responseObject, error in
//            print("Response Object:")
//            print(responseObject!)
//            print(error!)
//        }
        performSegue(withIdentifier: "goToGameView", sender: self)
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
