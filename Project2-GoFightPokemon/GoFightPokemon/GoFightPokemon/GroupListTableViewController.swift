//
//  GroupListTableViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GroupListTableViewController: UITableViewController, GroupDelegate {


    let groupsetManager = GroupManager()

    var getItem: [GroupItem] = []

    func manager(_ controller: GroupManager, success: Bool){

    }
    func manager(_ controller: GroupManager, groupItem: [GroupItem]){


        getItem = groupItem

        self.tableView.reloadData()

    }


    @IBAction func goBackFuncList(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }






    override func viewDidLoad() {
        super.viewDidLoad()


        groupsetManager.delegate = self
        groupsetManager.getGroupItem()
       // tableView.reloadData()



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
        return self.getItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupListTableViewCell
        cell.gymLevel.text = getItem[indexPath.row].gymLevel
        cell.bossName.text = getItem[indexPath.row].bossName


        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToGroupReview" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DiscussionViewController

                destinationController.gymLevelName = getItem[indexPath.row].gymLevel
                destinationController.bossNameName = getItem[indexPath.row].bossName
                destinationController.childIdName = getItem[indexPath.row].childId
                destinationController.ownerIdName = getItem[indexPath.row].ownerId


            }
        }


    }




}

