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
    func manager(_ controller: PersonManager)
    func manager(_ controller: PersonManager, userItem: UserItem)
}



class PersonManager {

    let uid = Auth.auth().currentUser?.uid
    var delegate: PersonDelegate? = nil

    func setPersonItem(nickName: String, playerTeam: String, playerLevel: String, gymLevel: String, headPhoto: String, userId: String,  userEmail: String) {

        let reference: DatabaseReference! = Database.database().reference().child("users").child(uid!)

        var person : [String : AnyObject] = [String : AnyObject]()

        person["userId"] = Auth.auth().currentUser?.uid as AnyObject

        person["userEmail"] = Auth.auth().currentUser?.email as AnyObject

        person["nickName"] = nickName as AnyObject

        person["headPhoto"] = headPhoto as AnyObject

        person["playerLevel"] = playerLevel as AnyObject

        person["playerTeam"] = playerTeam as AnyObject

        reference.updateChildValues(person) { (err, ref) in

            if err == nil {
                self.delegate?.manager(self, success: true)
                return
            }
            

        }
    }

    func setValuePersonItem(teamSelect: String, levelSelect: String, gymLevelSelect: String ){

        let dataBaseRef = Database.database().reference().child("users").child(uid!)


        dataBaseRef.child("playerTeam").setValue(teamSelect, withCompletionBlock: { (error, data) in

            if error != nil {

                print("Database Error: \(error!.localizedDescription)")
            }
            else {
                print("team has saved")
            }
        }
        )


        dataBaseRef.child("playerLevel").setValue(levelSelect, withCompletionBlock: { (error, data) in

            if error != nil {

                print("Database Error: \(error!.localizedDescription)")
            }
            else {
                print("playerLevel has saved")
            }
        }
        )

        dataBaseRef.child("gymLevel").setValue(gymLevelSelect, withCompletionBlock: { (error, data) in

            if error != nil {

                print("Database Error: \(error!.localizedDescription)")
            }
            else {
                print("challengeLevel has saved")
            }
        }
        )

        self.delegate?.manager(self)
    }




    func getPersonItem() {

       Database.database().reference().child("users").child(uid!).observe(.value, with: {(snapshot) in

        print("🏧")
        print(snapshot)
        print("🏧")
            let data = UserItem(snapshot: snapshot)
            self.delegate?.manager(self, userItem: data)



        })

    }



}



