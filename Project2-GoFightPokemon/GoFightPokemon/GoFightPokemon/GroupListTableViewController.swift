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

class GroupListTableViewController: UITableViewController {

    @IBAction func goBackFuncList(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }

    var handle: DatabaseHandle?
    var reference: DatabaseReference?

    var getItem: [GroupItem] = []


    override func viewDidLoad() {
        super.viewDidLoad()


        reference = Database.database().reference()
        handle = reference?.child("groupFight").observe(.value, with: {(snapshot) in

   print(snapshot)



            if snapshot.childrenCount > 0 {


                var datalist: [GroupItem] = []

                for item in snapshot.children {
                    let data = GroupItem(snapshot: item as! DataSnapshot)
                    datalist.append(data)


    print(datalist)
                    self.getItem = datalist
                    self.tableView.reloadData()

                }

            }

        })

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

