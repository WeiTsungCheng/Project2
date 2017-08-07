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

class DiscussionViewController: UIViewController, DiscussionDelegate, PersonDelegate {

    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }
    func manager(_ controller: PersonManager, userItem: UserItem){

       getUserItem = userItem

    self.tableView.reloadData()

    }


    func manager(_ controller: DiscussionManager, success: Bool){

    }
    func manager(_ controller: DiscussionManager, groupItem: [DiscussionItem]){


       getItem = groupItem


       self.tableView.reloadData()

    }

    let discussionManager = DiscussionManager()

    let personManager = PersonManager()


    let uid = Auth.auth().currentUser?.uid

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var gymLevel: UILabel!
    @IBOutlet weak var bossName: UILabel!

    @IBOutlet weak var writeComment: UITextView!


    //設定新變數為了從GroupListTabaleView傳值過來
    var gymLevelName = ""
    var bossNameName = ""

    //需要傳入這場團戰的childId才能找到正確的團戰位置
    var childIdName = ""
    var ownerIdName = ""

    var reference: DatabaseReference?
    var getItem: [DiscussionItem] = []

    //設定一個字典裝，uid為key,value為UserItem
    var getPersonInfo: [String: UserItem] = [:]
    var getUserItem: UserItem?



    @IBAction func sendComment(_ sender: Any) {

      discussionManager.setDiscussionItem(writeComment: writeComment.text, childId: childIdName)


    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //從GroupListTableViewCell傳值過來
        gymLevel.text = gymLevelName
        bossName.text = bossNameName
        discussionManager.delegate = self
        
        discussionManager.getDiscussionItem(childId: childIdName)

        personManager.delegate = self



        




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


        if getPersonInfo[getItem[indexPath.row].participantId] == nil {

            personManager.getOtherPersonItem(userId: getItem[indexPath.row].participantId)

            getPersonInfo[getItem[indexPath.row].participantId] = getUserItem

            print("⭕️")

        } else {

            cell.putComment.text = getItem[indexPath.row].participantComment

            cell.playerNickName.text = getUserItem?.nickName

            print("❌")
        }

            return cell

    }

}

//        if userDictionary[getItem[indexPath.row].participantId] == nil{
//
//            manager.抓資料{
//
//            }
//
//
//        }  else{
//
//            show on cell
//
//        }











