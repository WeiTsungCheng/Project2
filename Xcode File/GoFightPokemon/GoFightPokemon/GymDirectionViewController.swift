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

    @IBOutlet weak var googleMaps: GMSMapView!

    @IBOutlet weak var startLocation: UITextField!

    @IBOutlet weak var destinatoionLocation: UITextField!


    //產生一個CLLocationManager實體
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation

    var locationStart = CLLocation()
    var locationEnd = CLLocation()


    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        //需要用戶接受存取裝置地點
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        //初始化地圖 (設置地圖位置在台北101)
        let camera = GMSMutableCameraPosition.camera(withLatitude: 25.024035, longitude: 121.528761, zoom: 16)
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps.isMyLocationEnabled = true
        self.googleMaps.settings.compassButton = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //客製化地圖圖釘的方法
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees){

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }

    //實作CLLocation manager的方法
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location:  \(error)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //只取最後一個抓到的地址
        let location = locations.last

        createMarker(titleMarker: "我的位置", iconMarker: #imageLiteral(resourceName: "Pokemon_Go-01-128"), latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)

        //停止抓取用戶裝置位置
        self.locationManager.stopUpdatingLocation()

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
        print("🍎")
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
            print("🍧🍧🍧🍧🍧")
            print(response.request as Any)  // original URL request
            print("🍧🍧🍧")
            print(response.response as Any) // HTTP URL response
            print("🍧")
            print(response.data as Any)     // server data
            print("🍧🍧🍧")
            print(response.result as Any)   // result of response serialization
            print("🍧🍧🍧🍧🍧")

            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue

            for route in routes {

                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                //點與點之間的線
                let polyline = GMSPolyline.init(path: path)

                polyline.strokeWidth = 5
                polyline.strokeColor = UIColor.blue
                polyline.map = self.googleMaps
            }
        }
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

    @IBAction func openDestinationLocation(_ sender: UIButton) {

        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self

        //選擇地點
        locationSelected = Location.destinaitonLocation
        UISearchBar.appearance().setTextColor(color: UIColor.gray)
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

            startLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "起始站", iconMarker: #imageLiteral(resourceName: "014-_Pokestop_-_PokeBall_-_Game_-_Pokemon_-_Pokemongo-128"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else {

            destinatoionLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"

            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "終點站", iconMarker: #imageLiteral(resourceName: "Pokemon_Go-11-128"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
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










