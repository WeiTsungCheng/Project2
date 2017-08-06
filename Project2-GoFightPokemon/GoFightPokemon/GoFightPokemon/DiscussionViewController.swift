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

class DiscussionViewController: UIViewController, DiscussionDelegate {


    func manager(_ controller: DiscussionManager, success: Bool){

    }
    func manager(_ controller: DiscussionManager, groupItem: [DiscussionItem]){

       getItem = groupItem

        self.tableView.reloadData()

    }
    let discussionManager = DiscussionManager()

    let uid = Auth.auth().currentUser?.uid

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var gymLevel: UILabel!
    @IBOutlet weak var bossName: UILabel!

    @IBOutlet weak var writeComment: UITextView!


    //設定新變數為了從GroupListTabaleView傳值過來
    var gymLevelName = ""
    var bossNameName = ""
    var childIdName = ""
    var ownerIdName = ""

    var reference: DatabaseReference?
    var getItem: [DiscussionItem] = []
    var personItem : [PersonItem] = []


    @IBAction func sendComment(_ sender: Any) {

      discussionManager.setGroupItem(writeComment: writeComment.text)


    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //從GroupListTableViewCell傳值過來
        gymLevel.text = gymLevelName
        bossName.text = bossNameName
        discussionManager.delegate = self
        discussionManager.getGroupItem()


        //取player個人資料

/////////

//        Database.database().reference().child("users").observe(.value, with: {(snapshot) in
//
//            print(snapshot)
//
//        if snapshot.childrenCount > 0 {
//
//            var datalist: [PersonItem] = [PersonItem]()
//
//
//            for item in snapshot.children {
//                    let data = PersonItem(snapshot: item as! DataSnapshot)
//                    datalist.append(data)
//
//
//                    print(datalist)
//                    self.personItem = datalist
//
//                self.tableView.reloadData()
//                
//
//                    
//                }
//
//            }
//            
//        })

//////////

        




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension DiscussionViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionCell", for: indexPath) as! DiscussionTableViewCell

        cell.putComment.text = getItem[indexPath.row].participantComment

//        cell.playerNickName.text =  personItem[indexPath.row].nickName
//        cell.playerLevel.text = personItem[indexPath.row].playerLevel
//        cell.playerTeam.text = personItem[indexPath.row].playerTeam



        return cell
    }



}









