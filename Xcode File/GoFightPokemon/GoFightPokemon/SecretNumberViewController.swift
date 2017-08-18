//
//  secretNumberViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/26.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SecretNumberViewController: UIViewController {

    @IBOutlet weak var loginPage: UIButton!
    @IBOutlet weak var signupPage: UIButton!

    @IBOutlet weak var resetNo: UIButton!

    @IBOutlet weak var resetEmail: UITextField!


    @IBAction func resetPassword(_ sender: AnyObject) {

        if self.resetEmail.text == "" {

            let alertController = UIAlertController(title: "錯誤", message: "請輸入信箱", preferredStyle: .alert)


            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)


        } else {

            Auth.auth().sendPasswordReset(withEmail: self.resetEmail.text!, completion: { (error) in

                var title = ""
                var message = ""

                if error != nil {
                    title = "錯誤"
                    message = "此email格式不符合規定"
                } else {
                    title = "成功"
                    message = "密碼更改信已送出"
                    self.resetEmail.text = ""
                }

                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)

                self.present(alertController, animated: true, completion: nil)
            })
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginPage.setTitleShadowColor(UIColor.black, for: .normal)

        loginPage.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        loginPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)



        signupPage.setTitleShadowColor(UIColor.black, for: .normal)

        signupPage.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        signupPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)


    
        resetNo.setTitleColor(UIColor.prjOrangeRed, for: .normal)


        resetEmail.layer.cornerRadius = 16


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
