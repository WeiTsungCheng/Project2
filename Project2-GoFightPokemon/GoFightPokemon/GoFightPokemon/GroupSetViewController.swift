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

class GroupSetViewController: UIViewController, GroupDelegate {

    func manager(_ controller: GroupManager, success: Bool){

    }
    func manager(_ controller: GroupManager, groupItem: [GroupItem]){

    }

    let setGroupManager = GroupManager()


    @IBOutlet weak var gymLevel: UITextField!

    @IBOutlet weak var bossName: UITextField!

    

    @IBAction func groupSet(_ sender: UIButton) {

        setGroupManager.setGroupItem(gymLevel: gymLevel.text!, bossName: bossName.text!)



        self.navigationController?.popViewController(animated: true)





    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setGroupManager.delegate = self



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
