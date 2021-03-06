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


var getURLImageDic: [String : UIImage] = [:]

class DiscussionViewController: UIViewController, DiscussionDelegate, PersonDelegate, URLImageDelegate, ParticipantsDelegate{

    func manager(_ controller: ParticipantManager, success: Bool){

    }
    func manager(_ controller: ParticipantManager, participantsItem: [ParticipantsItem]){

    }

    func manager(_ controller: ParticipantManager, participantsCount: Int){
        participantNumbers.text = String(participantsCount)
    }
    func manager(_ controller: ParticipantManager, attendButton: Bool, cancelButton: Bool){

        attendFight.isEnabled  = attendButton
        leaveFight.isEnabled = cancelButton

        if attendFight.isEnabled == false {
            attendFight.backgroundColor = UIColor.gray
        }
        if leaveFight.isEnabled == false {
            leaveFight.backgroundColor = UIColor.gray
        }


    }


    let participantManager = ParticipantManager()

    @IBOutlet weak var clearComment: UIButton!


    @IBAction func clearCommentBtn(_ sender: UIButton) {

        writeComment.text = ""

    }


    @IBOutlet weak var participantNumbers: UILabel!

    @IBOutlet weak var attendFight: UIButton!

    @IBOutlet weak var leaveFight: UIButton!

    @IBOutlet weak var giveComment: UIButton!

    @IBOutlet weak var howToGo: UIButton!

    
    @IBAction func gymHowToGo(_ sender: Any) {
         Analytics.logEvent("gymHowToGo", parameters: nil)
    }

    @IBAction func participantList(_ sender: Any) {
         Analytics.logEvent("participantList", parameters: nil)
    }


    @IBAction func attendFight(_ sender: Any) {

        participantManager.setParticipantItem(childId: childIdName)

        participantManager.getParticipantsCountItem(childId: childIdName)

        leaveFight.isEnabled = true
        leaveFight.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        attendFight.isEnabled  = false
        attendFight.backgroundColor = UIColor.gray
    }


    @IBAction func leaveFight(_ sender: Any) {

        participantManager.cancelParticipantItem(childId: childIdName)

        participantManager.getParticipantsCountItem(childId: childIdName)

        attendFight.isEnabled  = true
        attendFight.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        leaveFight.isEnabled = false
        leaveFight.backgroundColor = UIColor.gray

    }





    func manager(_ controller: URLImageManager, imageIndexPath: IndexPath) {

        self.tableView.reloadRows(at: [imageIndexPath], with: .fade)

    }
    func manager(_ controller: PersonManager, success: Bool) {

    }
    func manager(_ controller: PersonManager) {

    }
    func manager(_ controller: PersonManager, userItem: UserItem) {

        //用updateValue找到key
        getPersonInfoDic.updateValue(userItem, forKey: userItem.userId)

        self.tableView.reloadData()

    }

    func manager(_ controller: DiscussionManager, success: Bool) {

    }
    func manager(_ controller: DiscussionManager, discussionItem: [DiscussionItem]) {

       getItem = discussionItem

       self.tableView.reloadData()

        //跳到最後的cell(因為從firebase 取資料時 倒轉了getItem的array,所以pathToLastRow 的row應該設為0)(如果並未倒轉,則row應該設為getItem.count -1)
        let pathToLastRow = NSIndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: pathToLastRow as IndexPath, at: UITableViewScrollPosition.top ,animated: false)

    }

    let discussionManager = DiscussionManager()

    let personManager = PersonManager()

    let urlImageManager = URLImageManager()

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var gymLevel: UILabel!
    @IBOutlet weak var bossName: UILabel!
    @IBOutlet weak var gymLocation: UILabel!

    @IBOutlet weak var writeComment: UITextView!

    //設定新變數為了從GroupListTabaleView傳值過來
    var gymLevelName = ""
    var bossNameName = ""
    var gymLocationName = ""

    //需要傳入這場團戰的childId才能找到正確的團戰位置
    var childIdName = ""
    var ownerIdName = ""

    var latitudeName = 0.00
    var longitudeName = 0.00

    var getItem: [DiscussionItem] = []

    //設定一個字典裝，uid為key,value為UserItem
    var getPersonInfoDic: [String: UserItem] = [:]

    @IBAction func sendComment(_ sender: Any) {


        discussionManager.setDiscussionItem(writeComment: writeComment.text, childId: childIdName)

        writeComment.text = ""

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //從GroupListTableViewCell傳值過來
        gymLevel.text = gymLevelName
        bossName.text = bossNameName
        gymLocation.text = gymLocationName
    
        discussionManager.delegate = self
        discussionManager.getDiscussionItem(childId: childIdName)

        personManager.delegate = self
        urlImageManager.delegate = self



        participantManager.delegate = self

        participantManager.getParticipantsCountItem(childId: childIdName)


        //檢查是否已經加入過此團，決定哪一個button可以用
        participantManager.checkAttend(childId: childIdName)


        giveComment.layer.cornerRadius = 10


        howToGo.backgroundColor = UIColor.clear
        howToGo.setImage(#imageLiteral(resourceName: "howToGo"), for: .normal)
        howToGo.contentMode = .scaleAspectFill


        clearComment.backgroundColor = UIColor.clear





        writeComment.layer.cornerRadius = 10



        attendFight.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        attendFight.setTitleColor(UIColor.white, for: .normal)

        leaveFight.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        leaveFight.setTitleColor(UIColor.white, for: .normal)



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if segue.identifier == "goToParticipantList" {
            let destinationController = segue.destination
                as! ParticipantListViewController
            //傳值到玩家列表
            destinationController.childIdNameName = childIdName
        } else {
            if segue.identifier == "goToGymDirection" {

                let destinationController = segue.destination
                    as! GymDirectionViewController

                //傳值到GymDirection
                destinationController.gymLocationNameName = gymLocationName
                destinationController.latitudeNameName = latitudeName
                destinationController.longitudeNameName = longitudeName



            }

        }

    }

}

extension DiscussionViewController : UITableViewDelegate, UITableViewDataSource {




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getItem.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {



        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension

        switch getItem[indexPath.row].participantId {

        case ownerIdName:

        let ownerCell = tableView.dequeueReusableCell(withIdentifier: "OwnerDiscussionCell", for: indexPath) as! OwnerDiscussionTableViewCell

        ownerCell.ownerPhoto.contentMode = .scaleAspectFill
        ownerCell.ownerPhoto.clipsToBounds = true
        ownerCell.ownerPhotoBase.clipsToBounds = true
        ownerCell.ownerPhoto.layer.cornerRadius = ownerCell.ownerPhoto.frame.width/2
        ownerCell.ownerPhotoBase.layer.cornerRadius = ownerCell.ownerPhotoBase.frame.width/2

        if getPersonInfoDic[getItem[indexPath.row].participantId] == nil {

            personManager.getOtherPersonItem(userId: getItem[indexPath.row].participantId)


        } else {



            ownerCell.putComment.layer.cornerRadius = 10

            ownerCell.putComment.text = getItem[indexPath.row].participantComment

            ownerCell.putComment.isUserInteractionEnabled = false

            ownerCell.ownerNickName.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.nickName

            if let thePlayerLevel = getPersonInfoDic[getItem[indexPath.row].participantId]?.playerLevel {
            ownerCell.ownerLevel.text = "等級" + String(describing: thePlayerLevel)
            }

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

            playerCell.playerPhoto.contentMode = .scaleAspectFill
            playerCell.playerPhoto.clipsToBounds = true
            playerCell.playerPhotoBase.clipsToBounds = true
            playerCell.playerPhoto.layer.cornerRadius = playerCell.playerPhoto.frame.width/2
            playerCell.playerPhotoBase.layer.cornerRadius = playerCell.playerPhotoBase.frame.width/2


            if getPersonInfoDic[getItem[indexPath.row].participantId] == nil {

                personManager.getOtherPersonItem(userId: getItem[indexPath.row].participantId)

            } else {


                playerCell.putComment.layer.cornerRadius = 10
                
                playerCell.putComment.text = getItem[indexPath.row].participantComment

                playerCell.putComment.isUserInteractionEnabled = false

                playerCell.playerNickName.text = getPersonInfoDic[getItem[indexPath.row].participantId]?.nickName

                if let thePlayerLevel = getPersonInfoDic[getItem[indexPath.row].participantId]?.playerLevel{
                playerCell.playerLevel.text = "等級" + String(describing: thePlayerLevel)
                }

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






