//
//  ViewControllerPostGame.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerPostGame: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var skillPicker: UISegmentedControl!
    @IBOutlet weak var goalieNumPIcker: UISegmentedControl!
    @IBOutlet weak var cityPicker: UIPickerView!
    var pickerDataSource = Shared.shared.locations
    var selectedValue: Int = 0
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var numGoalies: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        cityPicker.dataSource = self
        cityPicker.delegate = self

        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource!.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource?[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = row
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(_ sender: Any) {
        let first_name = firstName.text
        let last_name = lastName.text
        let skill_level = getSegment()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let datetime = dateFormatter.string(from: dateTimePicker.date)
        let url = "http://robcardy.com/game/"
        let parameters: [String: Any] = [
            "firstName": first_name!,
            "lastName": last_name!,
            "skillLevel": skill_level,
            "location": "http://robcardy.com/location/" + String(describing: (self.selectedValue + 7)) + "/",
            "datetime": "2018-01-10T10:00:00Z",
            "numOfGoalies": String(describing: (numGoalies.selectedSegmentIndex + 1))
        ]
        httpPOST(url:url, handler: Handlers.getMostRecentGame, parameters:parameters)
        
        performSegue(withIdentifier: "goToSearchingView", sender: self)
    }

    func getSegment() -> Int {
        switch skillPicker.selectedSegmentIndex {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
