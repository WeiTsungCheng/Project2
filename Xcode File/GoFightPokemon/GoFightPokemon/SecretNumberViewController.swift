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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
