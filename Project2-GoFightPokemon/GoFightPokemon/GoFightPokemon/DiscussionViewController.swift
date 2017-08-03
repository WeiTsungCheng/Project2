//
//  DiscussionViewController.swift
//  
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DiscussionViewController: UIViewController {

    @IBOutlet weak var gymLevel: UILabel!

    @IBOutlet weak var bossName: UILabel!

    @IBOutlet weak var writeComment: UITextView!

    var gymLevelName = ""
    var bossNameName = ""
    var childIdName = ""
    var ownerIdName = ""


    @IBAction func sendComment(_ sender: Any) {

        let childId = childIdName

     //   let ownerId = ownerIdName

        if self.writeComment.text == "" {

            return

        }
        let reference : DatabaseReference! =
                Database.database().reference().child("gropReview").child("\(childId)")

        var discussion: [String: AnyObject] = [String: AnyObject]()

     //   discussion["ownerId"] = ownerId as AnyObject
     //   discussion["participantEmail"] = Auth.auth().currentUser?.email as AnyObject
        discussion["childId"] = childId as AnyObject
        discussion["participantId"] = Auth.auth().currentUser?.uid as AnyObject
        discussion["participantComment"] = writeComment.text as AnyObject
        






    }











 


    override func viewDidLoad() {
        super.viewDidLoad()

        gymLevel.text = gymLevelName
        bossName.text = bossNameName





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
