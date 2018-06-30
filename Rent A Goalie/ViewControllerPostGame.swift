//
//  ViewControllerPostGame.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-04.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit

class ViewControllerPostGame: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let api = API()
    let parser = JSONParserCustom()
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var skillPicker: UISegmentedControl!
    @IBOutlet weak var goalieNumPIcker: UISegmentedControl!
    @IBOutlet weak var cityPicker: UIPickerView!
    var pickerDataSource: [String] = []
    var selectedValue: Int = 0
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var numGoalies: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        cityPicker.dataSource = self
        cityPicker.delegate = self
        api.getLocations() { responseObject, error in
            self.pickerDataSource = self.parser.parseLocations(json: responseObject!)
        }
        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let datetime = dateFormatter.string(from: dateTimePicker.date)
        let location: String = "http://robcardy.com/location/" + String(describing: (self.selectedValue + 7)) + "/"
        let game = Game(id: 0, firstName: firstName.text!, lastName: lastName.text!, skillLevel: getSegment(), location: location, datetime: datetime, goaliesNeeded: numGoalies.selectedSegmentIndex + 1, goalieOne: "", goalieTwo: "")
        
        api.postGame(game!) { responseObject, error in
            if (error == nil) {
                let returnedGame = self.parser.parseGame(json: responseObject!)
                // TODO: Send ID variable to next view controller in a good way
            }
            else {
                print("Error was returned as non- nil. Error: " + String(describing: error!))
            }
        }
        
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
