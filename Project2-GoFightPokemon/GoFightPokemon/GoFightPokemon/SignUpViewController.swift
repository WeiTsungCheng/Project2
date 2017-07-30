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

var autoID: String = ""

class SignUpViewController: UIViewController {

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
            Auth.auth().createUser(withEmail: signUpEmail.text!, password: signUpPassword.text!, completion: {(user, error) in

                if error == nil {
                    print("signUp success")

                    //建立dataBase 資料庫結構
                    let ref = Database.database().reference().child("users")

                    let childRef = ref.childByAutoId()

                    var userData : [String : AnyObject] = [String : AnyObject]()
                    userData["nickName"] = self.signUpNickName.text as AnyObject
                    userData["headPhoto"] = "photoAddress" as AnyObject
//                    userData["userId"] = Auth.auth().currentUser?.uid as AnyObject
//                    userData["userEmail"] = Auth.auth().currentUser?.email as AnyObject
                    userData["childId"] =  childRef.key as AnyObject

                    autoID = childRef.key

                    let userReference = ref.child(childRef.key)

                    userReference.updateChildValues(userData) { (err, ref) in
                        if err != nil {
                            print(err!)
                            return
                        }

                        user?.sendEmailVerification() { error in
                            if let error = error {
                                print(error)
                            } else {
                                print("email has sent")
                            }
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
