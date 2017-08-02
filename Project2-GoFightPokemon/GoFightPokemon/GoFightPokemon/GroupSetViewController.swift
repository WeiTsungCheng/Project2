//
//  GroupSetViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GroupSetViewController: UIViewController {

    @IBOutlet weak var gymLevel: UITextField!

    @IBOutlet weak var bossName: UITextField!


    @IBAction func groupSet(_ sender: UIButton) {



        let reference: DatabaseReference! = Database.database().reference().child("groupFight")

        let childRef = reference.childByAutoId()

        var group : [String : AnyObject] = [String : AnyObject]()

        group["ownerId"] = Auth.auth().currentUser?.uid as AnyObject

        group["gymLevel"] = gymLevel.text as AnyObject

        group["bossName"] = bossName.text as AnyObject

        group["childId"] = childRef.key as AnyObject

        group["setTime"] = "11:10 01/01/2018" as AnyObject

        group["gymLocation"] = "myHome" as AnyObject


        let groupReference = reference.child(childRef.key)

        groupReference.updateChildValues(group) { (err, ref) in
            if err != nil {
                print("err： \(err!)")
                return
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
