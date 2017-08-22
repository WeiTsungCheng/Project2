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

    @IBAction func setUserInformaiton(_ sender: Any) {
          Analytics.logEvent("setUserInformaiton", parameters: nil)
    }

    @IBAction func goGroupList(_ sender: Any) {
          Analytics.logEvent("goGroupList", parameters: nil)
    }



    @IBAction func logOut(_ sender: Any) {


        Analytics.logEvent("logOut", parameters: nil)

        let alertController = UIAlertController(title: "提醒", message: "真的要離開GoFightPokemon?", preferredStyle: .alert)

        let comfirmAlertAction = UIAlertAction(title: "確認", style: .default, handler: { (action: UIAlertAction) -> () in

            if Auth.auth().currentUser != nil {

                do {

                    try Auth.auth().signOut()

                    //登出刪除已存入的userDefault
                    let userDefauls = UserDefaults.standard

                    userDefauls.removeObject(forKey: "getuserEmail")

                    userDefauls.removeObject(forKey: "getuserPassword")

                    userDefauls.synchronize()


                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "entree")
                    let applicationDelegation = UIApplication.shared.delegate as? AppDelegate
                    applicationDelegation?.window?.rootViewController = nextVC
                    
                    
                } catch let error as NSError {
                    print(error)
                    
                }
                
            }

        })

        let cancelAlertAction = UIAlertAction(title: "取消", style: .default, handler: { (action: UIAlertAction) -> () in
        alertController.dismiss(animated: true, completion: nil)
        })


        alertController.addAction(comfirmAlertAction)
        alertController.addAction(cancelAlertAction)

        self.present(alertController, animated: true, completion: nil)


    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = UIBarStyle.black

        self.navigationController?.navigationBar.barTintColor = UIColor.black

        self.navigationController?.navigationBar.tintColor = UIColor.white


        self.logout.setTitle("離開", for: .highlighted)


        
        logout.tintColor = UIColor.gray

//        //Crashlytics 測試Crash
//        let button = UIButton(type: .roundedRect)
//        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//        button.setTitle("Crash", for: [])
//        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
//        view.addSubview(button)

    }

//    //Crashlytics 測試Crash
//    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//        Crashlytics.sharedInstance().crash()
//    }

    //autoLayout會發生在viewdidload 之後 ,所以會改變size 的button 要放入CAGradientLayer，必須在viewDidLayoutSubviews()做
    override func viewDidLayoutSubviews() {



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

        groupListGradient.frame = self.groupList.bounds

        groupListGradient.colors = [UIColor.purple.cgColor, UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1).cgColor]
        groupListGradient.opacity = 0.85

        groupListGradient.startPoint = CGPoint(x: 0, y: 0)
        groupListGradient.endPoint = CGPoint(x: 1, y: 1)

        groupListGradient.cornerRadius = 12

        self.groupList.layer.insertSublayer(groupListGradient, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
