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


    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signupPage: UIButton!
    @IBOutlet weak var resetPage: UIButton!

    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!

    @IBAction func goSignupPage(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SignupViewController")
        let applicationDelegation = UIApplication.shared.delegate as? AppDelegate
        applicationDelegation?.window?.rootViewController = nextVC
    }

    @IBAction func goResetPage(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ResetViewController")
        let applicationDelegation = UIApplication.shared.delegate as? AppDelegate
        applicationDelegation?.window?.rootViewController = nextVC

    }

    @IBAction func login(_ sender: AnyObject) {
        if loginEmail.text == "" || loginPassword.text == "" {
            let alertController = UIAlertController(title: "錯誤", message: "請輸入信箱和密碼", preferredStyle: UIAlertControllerStyle.alert)

            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(defaultAction)

            self.present(alertController, animated: true, completion: nil)

        } else {
            Auth.auth().signIn(withEmail: self.loginEmail.text!, password: self.loginPassword.text!, completion: {(_, error) in

                //是否通過驗證
                //  if user?.isEmailVerified == true {

                if error == nil {
                    print ("login success")

                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "goHome")
                    let applicationDelegation = UIApplication.shared.delegate as? AppDelegate
                    applicationDelegation?.window?.rootViewController = nextVC


                } else {

                    let alertController = UIAlertController(title: "錯誤", message: "錯誤的信箱或密碼", preferredStyle: UIAlertControllerStyle.alert)

                    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)

                    alertController.addAction(defaultAction)

                    self.present(alertController, animated: true, completion: nil)

                }

               // } else {
               //     print("email haven't verified")
              //  }

            }

        )}

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard

        //註冊完跳轉loginPage 直接填入在signUp時存入的信箱和密碼
        loginPassword.text = userDefaults.value(forKey: "getuserPassword") as? String
        loginEmail.text = userDefaults.value(forKey: "getuserEmail") as? String


        let loginPageGradient = CAGradientLayer()
        loginPageGradient.frame = self.view.frame
        loginPageGradient.colors = [UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1).cgColor, UIColor.white.cgColor]
        loginPageGradient.opacity = 0.7
        loginPageGradient.startPoint = CGPoint(x: 0, y: 1)
        loginPageGradient.endPoint = CGPoint(x: 1, y: 0)
        self.view.layer.insertSublayer(loginPageGradient, at: 0)


        login.backgroundColor = UIColor(red: 0/255, green: 118/255, blue: 255/255, alpha: 1)
        login.setTitleColor(UIColor.white, for: .normal)

        signupPage.setTitleShadowColor(UIColor.white, for: .normal)
        signupPage.setTitleColor(UIColor.black, for: .normal)
        signupPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)

        resetPage.setTitleShadowColor(UIColor.white, for: .normal)
        resetPage.setTitleColor(UIColor.black, for: .normal)
        resetPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)



        loginEmail.layer.cornerRadius = 16
        loginPassword.layer.cornerRadius = 16

    }

    override func viewDidLayoutSubviews() {
        login.layer.cornerRadius = 10
        login.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
