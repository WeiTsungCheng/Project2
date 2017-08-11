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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
