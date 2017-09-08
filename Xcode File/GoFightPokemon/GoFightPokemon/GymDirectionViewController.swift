//
//  GymDirectionViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/14.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

enum Location{

    case startLocation
    case destinaitonLocation
}

class GymDirectionViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    var gymLocationNameName = ""
    var latitudeNameName = 0.00
    var longitudeNameName = 0.00

    var currentLatitude = 0.00
    var currentLongitude = 0.00

    @IBOutlet weak var currentLocation: UIButton!

    @IBOutlet weak var gymLocation: UIButton!


    @IBOutlet weak var googleMaps: GMSMapView!

    @IBOutlet weak var startLocation: UITextField!

    @IBOutlet weak var destinatoionLocation: UITextField!

    @IBOutlet weak var getDriveRoute: UIButton!

    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation

    var locationStart = CLLocation()
    var locationEnd = CLLocation()

    var myMarker = GMSMarker()
    var startMarker = GMSMarker()
    var endMarker = GMSMarker()
    var myPolyline = GMSPolyline()



    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        //需要用戶接受存取裝置地點
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        self.googleMaps.delegate = self
        self.googleMaps.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.zoomGestures = true
        self.googleMaps.settings.compassButton = true

        //初始化地圖 (設置地圖位置在道館位置)
        let camera = GMSCameraPosition.camera(withLatitude: latitudeNameName, longitude: longitudeNameName, zoom: 16)

        //設定Gymlocation 的預設值
        destinatoionLocation.text = gymLocationNameName
        locationEnd = CLLocation(latitude: latitudeNameName, longitude: longitudeNameName)

        endMarker.map = nil
        endMarker.position = CLLocationCoordinate2D(latitude: latitudeNameName, longitude: longitudeNameName)
        endMarker.title = "道館位置"
        endMarker.icon = #imageLiteral(resourceName: "endLocation")
        endMarker.map = googleMaps

        self.googleMaps.camera = camera

        destinatoionLocation.isEnabled = false

        gymLocation.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        gymLocation.setTitleColor(UIColor.white, for: .normal)


        currentLocation.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        currentLocation.setTitleColor(UIColor.white, for: .normal)

    }

    override func viewDidLayoutSubviews() {
        getDriveRoute.layer.cornerRadius = 12
        getDriveRoute.setTitleColor(UIColor.white, for: .normal)

        let setSaveHeadPhotoGradient = CAGradientLayer()
        setSaveHeadPhotoGradient.frame = getDriveRoute.bounds
        setSaveHeadPhotoGradient.colors = [UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1).cgColor, UIColor(red: 0/255, green: 85/255, blue: 216/255, alpha: 1).cgColor]
        setSaveHeadPhotoGradient.opacity = 0.85
        setSaveHeadPhotoGradient.startPoint = CGPoint(x: 0, y: 0)
        setSaveHeadPhotoGradient.endPoint = CGPoint(x: 1, y: 1)
        setSaveHeadPhotoGradient.cornerRadius = 12
        getDriveRoute.layer.insertSublayer(setSaveHeadPhotoGradient, at: 0)

        getDriveRoute.layer.shadowColor = UIColor.black.cgColor
        getDriveRoute.layer.shadowRadius = 2
        getDriveRoute.layer.shadowOffset = CGSize(width: 0, height: 2)
        getDriveRoute.layer.shadowOpacity = 0.8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //實作CLLocation manager的方法
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location:  \(error)")

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //只取最後一個抓到的地址

        if let location = locations.last {

            currentLatitude = location.coordinate.latitude
            currentLongitude = location.coordinate.longitude

            myMarker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            myMarker.title = "我的位置"
            myMarker.icon = #imageLiteral(resourceName: "currentLocation")
            myMarker.map = googleMaps

            //停止抓取用戶裝置位置
         //   self.locationManager.stopUpdatingLocation()

        }

    }

    //實作GMSMapViewDelegate方法

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false

    }

    //點擊地圖時此function被執行
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {

        print("Coordinate: \(coordinate)")
    }

    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {

        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    //畫出行進路徑的方法
    func drawpath(startLocation: CLLocation, endLocation: CLLocation){

        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"

        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"

        Alamofire.request(url).responseJSON{
            response in

            print(response.request as Any)  // original URL request

            print(response.response as Any) // HTTP URL response

            print(response.data as Any)     // server data

            print(response.result as Any)   // result of response serialization

            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue

            for route in routes {

                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                //點與點之間的線

                self.myPolyline.map = nil

                self.myPolyline = GMSPolyline.init(path: path)

                self.myPolyline.strokeWidth = 5
                self.myPolyline.strokeColor = UIColor.blue


                self.myPolyline.map = self.googleMaps
            }
        }
    }

    //以當前位置作為起始點
    @IBAction func currentAsStartLocatoin(_ sender: UIButton) {

          let camera = GMSCameraPosition.camera(withLatitude: currentLatitude, longitude: currentLongitude, zoom: 16)

          self.locationStart = CLLocation(latitude: currentLatitude, longitude: currentLongitude)

          self.startLocation.text = "緯度：\(currentLatitude), 經度：\(currentLongitude)"

          self.googleMaps.camera = camera

    }


    //搜尋起始位置
    @IBAction func openStartLocation(_ sender: UIButton) {

        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self

        //選擇地點
        locationSelected = Location.startLocation
        UISearchBar.appearance().setTextColor(color: UIColor.brown)

        self.locationManager.stopUpdatingLocation()

        self.present(autoCompleteController, animated: true, completion: nil)
    }

    //搜尋到達位置
    @IBAction func openDestinationLocation(_ sender: UIButton) {

        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self

        //選擇地點
        locationSelected = Location.destinaitonLocation
        UISearchBar.appearance().setTextColor(color: UIColor.brown)

        self.locationManager.stopUpdatingLocation()

        self.present(autoCompleteController, animated: true, completion: nil)


    }


    @IBAction func showDirection(_ sender: UIButton) {

        self.drawpath(startLocation: locationStart, endLocation: locationEnd)

    }



}


extension GymDirectionViewController: GMSAutocompleteViewControllerDelegate{

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {

        print("Error \(error)")
    }


    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16)

        if locationSelected == Location.startLocation {

            startLocation.text = place.formattedAddress

            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)

            startMarker.map = nil
            startMarker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            startMarker.title = "出發位置"
            startMarker.icon = #imageLiteral(resourceName: "startLocation")
            startMarker.map = googleMaps

        } else {

            destinatoionLocation.text = place.formattedAddress

            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)

            endMarker.map = nil
            endMarker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            endMarker.title = "道館位置"
            endMarker.icon = #imageLiteral(resourceName: "endLocation")
            endMarker.map = googleMaps

        }

        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}

public extension UISearchBar {

    public func setTextColor(color: UIColor) {

        let svs = subviews.flatMap {$0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
        
    }
}










