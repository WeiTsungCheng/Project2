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
