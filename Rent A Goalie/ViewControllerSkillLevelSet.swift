//
//  ViewControllerSkillLevelSet.swift
//  Rent A Goalie
//
//  Created by Rob Cardy on 2017-11-20.
//  Copyright © 2017 Cardy Inc. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerSkillLevelSet: UIViewController {

    @IBOutlet var skillLevelDescription: UILabel!
    @IBOutlet var skillPicker: UISegmentedControl!
    @IBOutlet var locationSearch: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    let skillDescriptions: [String] = ["You've played pro hockey somewhat recently",
    "Junior A, Div 1", "Mixed Junior A/B, Div 2-3", "Junior B, Div 4-6", "Div 7-10, Beginners, Casual Pickup"]
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        skillLevelDescription.text = skillDescriptions[Int(skillPicker.selectedSegmentIndex)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        skillLevelDescription.text = skillDescriptions[Int(skillPicker.selectedSegmentIndex)]
        mapView.mapType = MKMapType.standard
        let location = CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.69812)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
//        mapView.showsUserLocation = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let location = CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.69812)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func handle(_ addressString: String) {
        getCoordinate(addressString: addressString) { (location, error) in
            if error == nil {
//                self.long.text = String(describing: location.longitude)
//                self.lat.text = String(describing: location.latitude)
                print(location)
//                mapView.add
            }
        }
    }
    
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
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
