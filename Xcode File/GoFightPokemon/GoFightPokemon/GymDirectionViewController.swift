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

class GymDirectionViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var googleMaps: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
