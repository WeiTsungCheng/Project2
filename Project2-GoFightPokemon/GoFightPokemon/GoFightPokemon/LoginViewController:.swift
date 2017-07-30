//
//  LoginViewController:.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/26.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController_: UIViewController {

    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!


    @IBAction func login(_ sender: AnyObject) {
        if loginEmail.text == "" || loginPassword.text == "" {
            let alertController = UIAlertController(title: "錯誤", message: "請輸入信箱和密碼", preferredStyle: UIAlertControllerStyle.alert)

            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(defaultAction)

            self.present(alertController, animated: true, completion: nil)

        } else {
            Auth.auth().signIn(withEmail: self.loginEmail.text!, password: self.loginPassword.text!, completion: {(user, error) in




                //是否通過驗證
                if user?.isEmailVerified == true {





                if error == nil {
                    print ("login success")

                    //將資料存在用戶的userDefault，使其下次點開app不需要重新輸入email和密碼
                    let userDefauls = UserDefaults.standard


                    let userEmail = self.loginEmail.text
                    let userPassword = self.loginPassword.text

                    userDefauls.set(userEmail, forKey: "getuserEmail")
                    userDefauls.set(userPassword, forKey: "getuserPassword")
                    userDefauls.synchronize()




                    let goHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "goHome")

                    self.present(goHomeVC!, animated: true, completion: nil)
                }

                else {

                    let alertController = UIAlertController(title: "錯誤", message: "錯誤的信箱或密碼", preferredStyle: UIAlertControllerStyle.alert)

                    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)

                    alertController.addAction(defaultAction)

                    self.present(alertController, animated: true, completion: nil)


                }




                } else {
                    print("email haven't verified")
                }





            }

        )}


    }





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
