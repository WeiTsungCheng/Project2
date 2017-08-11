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

   // let uid = Auth.auth().currentUser?.uid
    weak var delegate: PersonDelegate?

    func setPersonItem(nickName: String, playerTeam: String, playerLevel: String, gymLevel: String, headPhoto: String, userId: String, userEmail: String) {

        let reference = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)

        var person: [String : AnyObject] = [String: AnyObject]()

        person["userId"] = userId as AnyObject

        person["userEmail"] = userEmail as AnyObject

        person["nickName"] = nickName as AnyObject

        person["headPhoto"] = headPhoto as AnyObject

        person["playerLevel"] = playerLevel as AnyObject

        person["playerTeam"] = playerTeam as AnyObject

        person["gymLevel"] = gymLevel as AnyObject

        reference.updateChildValues(person) { (err, _) in

            if err == nil {
                self.delegate?.manager(self, success: true)
                return
            }

        }
    }

    func setValuePersonItem(teamSelect: String, levelSelect: String, gymLevelSelect: String ) {

        let dataBaseRef = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)

        dataBaseRef.child("playerTeam").setValue(teamSelect, withCompletionBlock: { (error, _) in

            if error != nil {

                print("Database Error: \(error!.localizedDescription)")
            } else {
                print("team has saved")
            }
        }
        )

        dataBaseRef.child("playerLevel").setValue(levelSelect, withCompletionBlock: { (error, _) in

            if error != nil {

                print("Database Error: \(error!.localizedDescription)")
            } else {
                print("playerLevel has saved")
            }
        }
        )

        dataBaseRef.child("gymLevel").setValue(gymLevelSelect, withCompletionBlock: { (error, _) in

            if error != nil {

                print("Database Error: \(error!.localizedDescription)")
            } else {
                print("challengeLevel has saved")
            }
        }
        )

        self.delegate?.manager(self)
    }

    func getPersonItem() {

       Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: {(snapshot) in

        print("🏧")
        print(snapshot)
        print("🏧")
            let data = UserItem(snapshot: snapshot)
            self.delegate?.manager(self, userItem: data)

        })

    }

    func getOtherPersonItem(userId: String) {

        Database.database().reference().child("users").child(userId).observe(.value, with: {(snapshot) in

            let data = UserItem(snapshot: snapshot)
            self.delegate?.manager(self, userItem: data)

        })

    }

}
