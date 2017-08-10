//
//  GroupListTableViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit


class GroupListTableViewController: UITableViewController, GroupDelegate {


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

    let personManager = PersonManager()







    override func viewDidLoad() {
        super.viewDidLoad()


        groupsetManager.delegate = self
        groupsetManager.getGroupItem()




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





        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToGroupDiscussion" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DiscussionViewController

                destinationController.gymLevelName = getItems[indexPath.row].gymLevel
                destinationController.bossNameName = getItems[indexPath.row].bossName
                destinationController.childIdName = getItems[indexPath.row].childId
                destinationController.ownerIdName = getItems[indexPath.row].ownerId


            }
        }


    }

}

