//
//  PersonInfoManager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/6.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
protocol PersonDelegate: class {

    func manager(_ controller: PersonManager, success: Bool)
    func manager(_ controller: PersonManager, groupItem: [UserItem])
}

class PersonManager {

    var delegate: PersonDelegate? = nil

    func setPersonItem(nickName: String, playerTeam: String, playerLevel: String, gymLevel: String, headPhoto: String, userId: String,  userEmail: String) {

        let reference: DatabaseReference! = Database.database().reference().child("users")

        let childRef = reference.childByAutoId()


        var person : [String : AnyObject] = [String : AnyObject]()

        person["userId"] = Auth.auth().currentUser?.uid as AnyObject

        person["userEmail"] = Auth.auth().currentUser?.email as AnyObject

        person["nickName"] = nickName as AnyObject

        person["headPhoto"] = headPhoto as AnyObject

        person["playerLevel"] = playerLevel as AnyObject

        person["playerTeam"] = playerTeam as AnyObject


        let groupReference = reference.child(childRef.key)

        groupReference.updateChildValues(person) { (err, ref) in

            if err == nil {
                self.delegate?.manager(self, success: true)
                return
            }
            
            
        }
    }



}



