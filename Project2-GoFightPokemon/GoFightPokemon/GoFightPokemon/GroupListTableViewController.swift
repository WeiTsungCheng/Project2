//
//  GroupListTableViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit


class GroupListTableViewController: UITableViewController, GroupDelegate, PersonDelegate {


    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }
    func manager(_ controller: PersonManager, userItem: UserItem){

        getUserItemDic?.updateValue(userItem, forKey: userItem.userId)

        self.tableView.reloadData()
    }



    var getUserItemDic: [String : UserItem]?




    let personManager = PersonManager()

    


    let groupsetManager = GroupManager()

    var getItems: [GroupItem] = []

    func manager(_ controller: GroupManager, success: Bool){

    }
    func manager(_ controller: GroupManager, groupItem: [GroupItem]){


        getItems = groupItem

        self.tableView.reloadData()

    }


    @IBAction func goBackFuncList(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }








    override func viewDidLoad() {
        super.viewDidLoad()


        groupsetManager.delegate = self
        groupsetManager.getGroupItem()

        personManager.delegate = self

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.getItems.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupListTableViewCell
        cell.gymLevel.text = getItems[indexPath.row].gymLevel
        cell.bossName.text = getItems[indexPath.row].bossName
        cell.setTime.text = getItems[indexPath.row].setTime
        cell.gymLocation.text = getItems[indexPath.row].gymLocation




        if getUserItemDic?[getItems[indexPath.row].ownerId] == nil{
            personManager.getOtherPersonItem(userId: getItems[indexPath.row].ownerId) } else {

        cell.ownerNickName.text = getUserItemDic?[getItems[indexPath.row].ownerId]?.nickName

        }



        return cell
    }

    //segue 傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToGroupDiscussion" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DiscussionViewController

                destinationController.gymLevelName = getItems[indexPath.row].gymLevel
                destinationController.bossNameName = getItems[indexPath.row].bossName
                destinationController.childIdName = getItems[indexPath.row].childId
                destinationController.ownerIdName = getItems[indexPath.row].ownerId

                destinationController.gymLocationName = getItems[indexPath.row].gymLocation



            }
        }


    }

}

