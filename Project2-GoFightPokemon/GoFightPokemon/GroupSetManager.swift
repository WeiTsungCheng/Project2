//
//  GroupSetManager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/5.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase



protocol GroupDelegate: class {

    func manager(_ controller: GroupManager, success: Bool)
    func manager(_ controller: GroupManager, groupItem: [GroupItem])
}

class GroupManager {

    var delegate: GroupDelegate? = nil

    func setGroupItem(gymLevel: String, bossName: String) {


        let reference: DatabaseReference! = Database.database().reference().child("groupFight")

        let childRef = reference.childByAutoId()

        var group : [String : AnyObject] = [String : AnyObject]()

        group["ownerId"] = Auth.auth().currentUser?.uid as AnyObject

        group["gymLevel"] = gymLevel as AnyObject

        group["bossName"] = bossName as AnyObject

        group["childId"] = childRef.key as AnyObject

        group["setTime"] = "11:10 01/01/2018" as AnyObject

        group["gymLocation"] = "myHome" as AnyObject


        let groupReference = reference.child(childRef.key)

        groupReference.updateChildValues(group) { (err, ref) in
            
            if err == nil {
                self.delegate?.manager(self, success: true)
                return
            }


    }
    }


    func getGroupItem() {


        Database.database().reference().child("groupFight").observe(.value, with: {(snapshot) in

            print(snapshot)



            if snapshot.childrenCount > 0 {

                var datalist: [GroupItem] = [GroupItem]()

                for item in snapshot.children {
                    let data = GroupItem(snapshot: item as! DataSnapshot)
                    datalist.append(data)

                    print(datalist)

                }

                self.delegate?.manager(self, groupItem: datalist)
                
            }
            
        })

    }








    
}
