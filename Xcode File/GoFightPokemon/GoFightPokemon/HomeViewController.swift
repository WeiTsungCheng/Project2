//
//  HomeViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/26.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var setUserInfo: UIButton!
    @IBOutlet weak var groupList: UIButton!
    @IBOutlet weak var logout: UIButton!


    @IBAction func logOut(_ sender: Any) {


        if Auth.auth().currentUser != nil {


            do {

                try Auth.auth().signOut()

                //登出刪除已存入的userDefault
                let userDefauls = UserDefaults.standard

                userDefauls.removeObject(forKey: "getuserEmail")

                userDefauls.removeObject(forKey: "getuserPassword")

                userDefauls.synchronize()


                let entreeVC = self.storyboard?.instantiateViewController(withIdentifier: "entree")


                self.present(entreeVC!, animated: true, completion: nil)


            } catch let error as NSError {
                print(error)

            }

        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = UIBarStyle.black

        self.navigationController?.navigationBar.barTintColor = UIColor.black

        self.navigationController?.navigationBar.tintColor = UIColor.white


        self.logout.setTitle("離開", for: .highlighted)


        self.setUserInfo.layer.cornerRadius = 12

        self.setUserInfo.setTitleColor(UIColor.white, for: .normal)



        // 製造lsetUserInfo的漸層
        let setUserInfoGradient = CAGradientLayer()

        setUserInfoGradient.frame = setUserInfo.bounds
        setUserInfoGradient.colors = [UIColor.purple.cgColor, UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1).cgColor]
        setUserInfoGradient.opacity = 0.85

        setUserInfoGradient.startPoint = CGPoint(x: 0, y: 0)
        setUserInfoGradient.endPoint = CGPoint(x: 1, y: 1)

        setUserInfoGradient.cornerRadius = 12

        self.setUserInfo.layer.insertSublayer(setUserInfoGradient, at: 0)

        logout.tintColor = UIColor.gray


        self.groupList.layer.cornerRadius = 12


        self.groupList.setTitleColor(UIColor.white, for: .normal)

        // 製造loginView的漸層
        let groupListGradient = CAGradientLayer()

        groupListGradient.frame = setUserInfo.bounds
        groupListGradient.colors = [UIColor.purple.cgColor, UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1).cgColor]
        groupListGradient.opacity = 0.85

        groupListGradient.startPoint = CGPoint(x: 0, y: 0)
        groupListGradient.endPoint = CGPoint(x: 1, y: 1)

        groupListGradient.cornerRadius = 12

        self.groupList.layer.insertSublayer(groupListGradient, at: 0)
        
        logout.tintColor = UIColor.gray


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
