//
//  GroupSetViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

import GoogleMaps
import GooglePlaces

class GroupSetViewController: UIViewController, GroupDelegate {


    @IBOutlet weak var myMapImage: GMSMapView!


    func manager(_ controller: GroupManager, success: Bool) {

    }
    func manager(_ controller: GroupManager, groupItem: [GroupItem]) {

    }

    let setGroupManager = GroupManager()

    @IBOutlet weak var gymLocation: UITextField!

    @IBOutlet weak var gymLevel: UITextField!

    @IBOutlet weak var bossName: UITextField!


    var gymLavels = ["請選擇難度", "簡單", "普通", "困難", "極困難", "傳說"]

    let gymLevelChoose = UIPickerView()


    @IBAction func groupSet(_ sender: UIButton) {

        setGroupManager.setGroupItem(gymLevel: gymLevel.text!, bossName: bossName.text!, setTime: setTime.text!, gymLocation: gymLocation.text!, latitude: gymLatitude!, longitude: gymLongitude!)


        self.navigationController?.popViewController(animated: true)

    }

    @IBOutlet weak var setTime: UITextField!


    func datePickerValueChanged(sender: UIDatePicker) {


        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.short
        setTime.text = formatter.string(from: sender.date)

    }

    //建立地圖

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?

    var gymLatitude: CLLocationDegrees?
    var gymLongitude: CLLocationDegrees?


    func getMapPosition() {

        let camera = GMSCameraPosition.camera(withLatitude: gymLatitude!, longitude: gymLongitude!, zoom: 16.0)

         let mapView = GMSMapView.map(withFrame: myMapImage.frame, camera: camera)

//       let mapView = GMSMapView.map(withFrame: CGRect(x: 16, y: 182, width: 343, height: 252), camera: camera)


//        let mapView = GMSMapView.map(withFrame: CGRect(x: 16, y: 182, width: 343, height: 252), camera: camera)


        mapView.isMyLocationEnabled = true

        view.addSubview(mapView)

        let gmsMarket = GMSMarker()


        gmsMarket.position = CLLocationCoordinate2D(latitude: gymLatitude!, longitude: gymLongitude!)

        gmsMarket.map = mapView

    }

    override func viewDidLoad() {
        super.viewDidLoad()


        gymLocation.isEnabled = false
        gymLevelChoose.delegate = self
        gymLevel.inputView = gymLevelChoose

        setGroupManager.delegate = self


        let gymTimePicker = UIDatePicker()
        gymTimePicker.datePickerMode = UIDatePickerMode.dateAndTime
        gymTimePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        setTime.inputView = gymTimePicker

        //建立地圖搜尋控制器
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController


        let subView = UIView(frame: CGRect(x: 16, y: 130.0, width: 342, height: 45.0))

        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        definesPresentationContext = true



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension GroupSetViewController: UIPickerViewDelegate{


    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return gymLavels.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        let titleRow = gymLavels[row]

        return titleRow

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if row == 0 {

            gymLevel.text = ""

        } else {

            gymLevel.text = gymLavels[row]
        }
    }

}

extension GroupSetViewController: GMSAutocompleteResultsViewControllerDelegate {

    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
    didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false


        gymLatitude = place.coordinate.latitude

        gymLongitude = place.coordinate.longitude

    // Do something with the selected place.
    print("Place name: \(place.name)")
    print("Place address: \(String(describing: place.formattedAddress))")
    print("Place attributions: \(String(describing: place.attributions))")

    gymLocation.text = place.formattedAddress
    getMapPosition()

    }


    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
    didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
    }

    // Turn the network activity indicator on and off again.

    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
