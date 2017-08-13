//
//  ParticipantListViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/11.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class ParticipantListViewController: UIViewController, ParticipantsDelegate, PersonDelegate {
    @IBOutlet weak var tableView: UITableView!

    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }

    func manager(_ controller: PersonManager, userItem: UserItem){

        getParticpantInfoDic.updateValue(userItem, forKey: userItem.userId)

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
            }

            if let nickName = getParticpantInfoDic[getItems[index].playerId]?.nickName {

                destinationController.nickNameName = nickName
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
        cell.playerLevel.text =  getParticpantInfoDic[getItems[indexPath.row].playerId]?.playerLevel


        cell.showcaseBtn.tag = indexPath.row


        return cell

    }
}