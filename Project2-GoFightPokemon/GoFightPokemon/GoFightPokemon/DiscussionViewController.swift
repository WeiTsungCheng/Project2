//
//  DiscussionViewController.swift
//  
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//
//

import UIKit

class DiscussionViewController: UIViewController {

    @IBOutlet weak var gymLevel: UILabel!

    @IBOutlet weak var bossName: UILabel!

    var gymLevelName = ""
    var bossNameName = ""
    var childIdName = ""



    override func viewDidLoad() {
        super.viewDidLoad()

        gymLevel.text = gymLevelName
        bossName.text = bossNameName
        let childId = childIdName
print("⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️")
print(childId)
print("⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️⚜️")
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
