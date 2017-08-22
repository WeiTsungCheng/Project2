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
    @IBOutlet weak var mySearchBarView: UIView!

    var mapView = GMSMapView()


    func manager(_ controller: GroupManager, success: Bool) {

    }
    func manager(_ controller: GroupManager, groupItem: [GroupItem]) {

    }

    let setGroupManager = GroupManager()

    @IBOutlet weak var gymLocation: UITextField!

    @IBOutlet weak var gymLevel: UITextField!

    @IBOutlet weak var bossName: UITextField!

    @IBOutlet weak var setTime: UITextField!

    @IBOutlet weak var comfirmFight: UIButton!


    var gymLavels = ["請選擇難度", "簡單", "普通", "困難", "極困難", "傳說"]

    let gymLevelChoose = UIPickerView()


    @IBAction func groupSet(_ sender: UIButton) {




        if gymLocation.text == "" {

            let alertController = UIAlertController(title: "錯誤", message: "道館地點不可留白", preferredStyle: .alert)

            let alertAction = UIAlertAction(title: "確認", style: .default)

            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)
            
            return


        }

        guard let location = gymLocation.text else {

            return
            
        }

        guard let gymLatitude = gymLatitude else {

            return

        }

        guard let gymLongitude = gymLongitude else {

            return
            
        }

        if setTime.text == "" {

            let alertController = UIAlertController(title: "錯誤", message: "發團時間不可留白", preferredStyle: .alert)

            let alertAction = UIAlertAction(title: "確認", style: .default)

            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)
            
            return
        }

        guard let setTime = setTime.text else {
            return
        }


        if gymLevel.text == "" {

            let alertController = UIAlertController(title: "錯誤", message: "道館等級不可留白", preferredStyle: .alert)

            let alertAction = UIAlertAction(title: "確認", style: .default)

            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)

            return
        }

        guard let gymLevel = gymLevel.text else {
            return
        }



        if bossName.text == "" {

            let alertController = UIAlertController(title: "錯誤", message: "魔王名稱不可留白", preferredStyle: .alert)

            let alertAction = UIAlertAction(title: "確認", style: .default)

            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)
            
            return
        }

        guard let bossName = bossName.text else {
            return
        }


        setGroupManager.setGroupItem(gymLevel: gymLevel, bossName: bossName, setTime: setTime, gymLocation: location, latitude: gymLatitude, longitude: gymLongitude)


        self.navigationController?.popViewController(animated: true)

    }



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

        mapView = GMSMapView.map(withFrame: myMapImage.frame, camera: camera)

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

        // 設定地圖初始位置
        let camera = GMSCameraPosition.camera(withLatitude: 25.0444805, longitude: 121.5216595, zoom: 12)

        myMapImage.camera = camera

        comfirmFight.layer.borderWidth = 2.5
        comfirmFight.layer.borderColor = UIColor.brown.cgColor
        comfirmFight.backgroundColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        comfirmFight.setTitleColor(UIColor(red: 86/255, green: 50/255, blue: 18/255, alpha: 1)
            , for: .normal)
        comfirmFight.layer.cornerRadius = 10


    }

    override func viewDidLayoutSubviews() {
        
        //建立地圖搜尋控制器
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        mySearchBarView.tintColor = UIColor.blue

        mySearchBarView.addSubview((searchController?.searchBar)!)

        view.addSubview(mySearchBarView)
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
