//
//  signUpViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/26.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, PersonDelegate {

    func manager(_ controller: PersonManager, success: Bool) {

    }
    func manager(_ controller: PersonManager) {

    }
    func manager(_ controller: PersonManager, userItem: UserItem) {

    }


    let personmanager = PersonManager()


    @IBOutlet weak var signUpEmail: UITextField!

    @IBOutlet weak var signUpPassword: UITextField!

    @IBOutlet weak var signUpNickName: UITextField!

    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var loginPage: UIButton!
    @IBOutlet weak var resetPage: UIButton!

    

    @IBAction func signUp(_ sender: AnyObject) {


        if signUpEmail.text == "" || signUpPassword.text == "" || signUpNickName.text == "" {
            let alertController = UIAlertController(title: "錯誤", message: "請設定您的帳號,密碼,與暱稱", preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)


        } else {

            Auth.auth().createUser(withEmail: signUpEmail.text!, password:

                signUpPassword.text!, completion: {(user, error) in


                    if error == nil {

                        print("signUp success")


                        //呼叫personmanager建立資料

                        self.personmanager.setPersonItem(nickName: self.signUpNickName.text!, playerTeam: "", playerLevel: "", gymLevel: "", headPhoto: "", userId: (Auth.auth().currentUser?.uid)!, userEmail: (Auth.auth().currentUser?.email)!)


                        user?.sendEmailVerification { error in

                            if let error = error {

                                print(error)

                            } else {

                                print("email has sent")

                            }

                        }


                        //如果資料獲取成功跳轉頁面

                        let alertController = UIAlertController(title: "恭喜", message: "成功創建帳號", preferredStyle: UIAlertControllerStyle.alert)

                        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil )

                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)


                    } else {

                        let alertController = UIAlertController(title: "錯誤", message: "帳戶已存在，或此帳戶格式不符合規定", preferredStyle: UIAlertControllerStyle.alert)


                        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)

                        alertController.addAction(defaultAction)


                        self.present(alertController, animated: true, completion: nil)
                    }
            }
            )}
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        personmanager.delegate = self

        loginPage.setTitleShadowColor(UIColor.black, for: .normal)

        loginPage.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        loginPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)


        signup.setTitleColor(UIColor.prjSunYellow, for: .normal)


        resetPage.setTitleShadowColor(UIColor.black, for: .normal)

        resetPage.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        resetPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)



        signUpEmail.layer.cornerRadius = 16
        signUpNickName.layer.cornerRadius = 16
        signUpPassword.layer.cornerRadius = 16

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
