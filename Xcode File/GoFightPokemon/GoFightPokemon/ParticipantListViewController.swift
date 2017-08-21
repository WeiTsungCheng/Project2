//
//  ParticipantListViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/11.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ParticipantListViewController: UIViewController, ParticipantsDelegate, PersonDelegate {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var blueTeamNumber: UILabel!
    @IBOutlet weak var redTeamNumber: UILabel!
    @IBOutlet weak var yellowTeamNumber: UILabel!
    @IBOutlet weak var averagePlayerLevel: UILabel!

    @IBAction func goOthersShowcase(_ sender: Any) {
        Analytics.logEvent("goOthersShowcase", parameters: nil)
    }

    var playerTeamBlue = 0
    var playerTeamRed = 0
    var playerTeamYellow = 0

    var totoalLevel = 0
    var averageLevel = 0

    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }

    func manager(_ controller: PersonManager, userItem: UserItem){

        getParticpantInfoDic.updateValue(userItem, forKey: userItem.userId)

        totoalLevel += userItem.playerLevel


        if userItem.playerTeam == "急凍鳥隊" {

            playerTeamBlue += 1


            print("🏓")

          //   blueTeamNumber.text = "\(playerTeamBlue)" + "人"
        }

        if userItem.playerTeam == "火焰鳥隊" {

            playerTeamRed += 1

            print("🏓🏓")
            print(playerTeamRed)

          //  redTeamNumber.text = "\(playerTeamRed)" + "人"
        }

        if userItem.playerTeam == "閃電鳥隊" {

            playerTeamYellow += 1

            print("🏓🏓🏓")

         //   yellowTeamNumber.text = "\(playerTeamYellow)" + "人"
        }


        blueTeamNumber.text = "\(playerTeamBlue)" + "人"
        redTeamNumber.text = "\(playerTeamRed)" + "人"
        yellowTeamNumber.text = "\(playerTeamYellow)" + "人"


        averageLevel = totoalLevel / getParticpantInfoDic.count
        print("🍝")
        averagePlayerLevel.text = "\(averageLevel)"
        print("🍝")

        self.tableView.reloadData()

    }






    let personManager = PersonManager()

    func manager(_ controller: ParticipantManager, success: Bool){

    }



    
    func manager(_ controller: ParticipantManager, participantsItem: [ParticipantsItem]){

        getItems = participantsItem

        for item in getItems {

            personManager.getOtherPersonItem(userId: item.playerId)
            
        }
        self.tableView.reloadData()

    }



    func manager(_ controller: ParticipantManager, participantsCount: Int){

    }

    func manager(_ controller: ParticipantManager, attendButton: Bool, cancelButton: Bool){

    }
    let participantManager = ParticipantManager()

    

    //接收DiscussionViewController 接收資料
    var childIdNameName = ""


    var getItems: [ParticipantsItem] = []


    var getParticpantInfoDic: [String : UserItem] = [:]

 


    override func viewDidLoad() {
        super.viewDidLoad()

        print("🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼")
        print(childIdNameName)



        participantManager.delegate = self

        participantManager.getParticipantPersonItem(childId: childIdNameName)

        personManager.delegate = self





    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }


    //傳個別cell所帶的userId到下一頁

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        let destinationController = segue.destination as! OtherShowcaseViewController

        if let button = sender as? UIButton {

            let index = button.tag

            print("🍯")

            print(index)
            print("🍯")


            if let userId = getParticpantInfoDic[getItems[index].playerId]?.userId {
                destinationController.userIdName = userId

                print("🎱")

                print(userId)

                print("🎱")
            }

            if let nickName = getParticpantInfoDic[getItems[index].playerId]?.nickName {

                destinationController.nickNameName = nickName

                print("🎱")

                print(nickName)

                print("🎱")
            }
        }

    }

}

extension ParticipantListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return getItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PartivipantListCell", for: indexPath) as! ParticipantListTableViewCell



        cell.nickName.text =  getParticpantInfoDic[getItems[indexPath.row].playerId]?.nickName
        cell.playerTeam.text =  getParticpantInfoDic[getItems[indexPath.row].playerId]?.playerTeam


        //處裡顯示文字有optional 的問題
        if let thePlayerLevel = getParticpantInfoDic[getItems[indexPath.row].playerId]?.playerLevel{
            cell.playerLevel.text = String(describing: thePlayerLevel)
        }

        cell.showcaseBtn.layer.borderWidth = 2.5
        cell.showcaseBtn.layer.borderColor = UIColor.brown.cgColor
        cell.showcaseBtn.backgroundColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        cell.showcaseBtn.setTitleColor(UIColor(red: 86/255, green: 50/255, blue: 18/255, alpha: 1)
            , for: .normal)
        cell.showcaseBtn.layer.cornerRadius = 10
        
        cell.showcaseBtn.tag = indexPath.row


        return cell

    }
}
