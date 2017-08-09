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


var getURLImageDic : [String : UIImage] = [:]

class DiscussionViewController: UIViewController, DiscussionDelegate, PersonDelegate, URLImageDelegate {


    func manager(_ controller: URLImageManager, imageIndexPath: IndexPath){

        self.tableView.reloadRows(at: [imageIndexPath], with: .fade)

    }
    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }
    func manager(_ controller: PersonManager, userItem: UserItem){

        //用updateValue找到key
        getPersonInfoDic.updateValue(userItem, forKey: userItem.userId)


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

    let urlImageManager = URLImageManager()


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
    var getPersonInfoDic: [String: UserItem] = [:]

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

        urlImageManager.delegate = self


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


        switch getItem[indexPath.row].participantId  {

        case ownerIdName:


        let ownerCell = tableView.dequeueReusableCell(withIdentifier: "OwnerDiscussionCell", for: indexPath) as! OwnerDiscussionTableViewCell


        if getPersonInfoDic[getItem[indexPath.row].participantId] == nil {

            personManager.getOtherPersonItem(userId: getItem[indexPath.row].participantId)

        } else {

            ownerCell.putComment.text = getItem[indexPath.row].participantComment

            ownerCell.ownerNickName.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.nickName

            ownerCell.ownerLevel.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.playerLevel

            ownerCell.ownerTeam.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.playerTeam

            if getURLImageDic[(getPersonInfoDic[getItem[indexPath.row].participantId]?.headPhoto)!] == nil {

                urlImageManager.getURLImage(imageURL: (getPersonInfoDic[getItem[indexPath.row].participantId]?.headPhoto)!, indexPath: indexPath)

            } else {

                ownerCell.ownerPhoto.image = getURLImageDic[(getPersonInfoDic[getItem[indexPath.row].participantId]?.headPhoto)!]
            }


        }

        return ownerCell



        default:

            let playerCell = tableView.dequeueReusableCell(withIdentifier: "PlayerDiscussionCell", for: indexPath) as! DiscussionTableViewCell

            if getPersonInfoDic[getItem[indexPath.row].participantId] == nil {

                personManager.getOtherPersonItem(userId: getItem[indexPath.row].participantId)

            } else {

                playerCell.putComment.text = getItem[indexPath.row].participantComment

                playerCell.playerNickName.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.nickName

                playerCell.playerLevel.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.playerLevel

                playerCell.playerTeam.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.playerTeam

                if getURLImageDic[(getPersonInfoDic[getItem[indexPath.row].participantId]?.headPhoto)!] == nil {

                    urlImageManager.getURLImage(imageURL: (getPersonInfoDic[getItem[indexPath.row].participantId]?.headPhoto)!, indexPath: indexPath)

                } else {
                    
                   playerCell.playerPhoto.image = getURLImageDic[(getPersonInfoDic[getItem[indexPath.row].participantId]?.headPhoto)!]
                }

                
            }

            return playerCell

        }
    }
}
