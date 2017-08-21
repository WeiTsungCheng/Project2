//
//  ParticipantsManager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/11.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol ParticipantsDelegate: class {

    func manager(_ controller: ParticipantManager, success: Bool)

    func manager(_ controller: ParticipantManager, participantsItem: [ParticipantsItem])

    func manager(_ controller: ParticipantManager, participantsCount: Int)

    func manager(_ controller: ParticipantManager, attendButton: Bool, cancelButton: Bool)


}

class ParticipantManager {

    weak var delegate: ParticipantsDelegate?

    func setParticipantItem(childId: String){

    let reference =
        Database.database().reference().child("participantsMember").child(childId).child((Auth.auth().currentUser?.uid)!)

        var participant: [String: AnyObject] = [String: AnyObject]()

        participant["playerId"] = Auth.auth().currentUser?.uid as AnyObject

        reference.updateChildValues(participant){(err, _) in
            if err != nil {
                print("err \(err!)")
                return
        }

            print(reference.description())
            self.delegate?.manager(self, success: true)
        }

    }

    func cancelParticipantItem(childId: String){
        Database.database().reference().child("participantsMember").child(childId).child((Auth.auth().currentUser?.uid)!).removeValue { (error, _) in
            if error != nil {
                print(error!)
                return
            }

            print("leave group success...")

    }
    }


    func getParticipantsCountItem(childId: String){
        Database.database().reference().child("participantsMember").child(childId).observe(.value, with: {(snapshot) in

            let participantsCount = snapshot.childrenCount

            print(snapshot)
            print(snapshot.childrenCount)

            self.delegate?.manager(self, participantsCount: Int(participantsCount))

        })

    }



    func checkAttend(childId: String){
        let query = Database.database().reference().child("participantsMember").child(childId).queryOrdered(byChild: "playerId").queryEqual(toValue: Auth.auth().currentUser?.uid)

        query.observeSingleEvent(of: .value, with: { (snapshot)

            in

            if let data = snapshot.value{

             

            guard
                let participantsMember = data as? [String: AnyObject],
                let playerId = participantsMember[(Auth.auth().currentUser?.uid)!]

                else {

                    let attendButton = true
                    let cancelButton = false

                    self.delegate?.manager(self, attendButton: attendButton, cancelButton: cancelButton)
                    return
                }

                print(playerId)

                let attendButton = false
                let cancelButton = true
                self.delegate?.manager(self, attendButton: attendButton, cancelButton: cancelButton)

            }

        })

    }

    func getParticipantPersonItem(childId: String) {
        Database.database().reference().child("participantsMember").child(childId).observe(.value, with: {(snapshot) in


            print(snapshot)

            if snapshot .childrenCount > 0 {

                var dataList: [ParticipantsItem] = [ParticipantsItem]()

                for item in snapshot.children {

                    let data = ParticipantsItem(snapshot: item as! DataSnapshot)

                    dataList.append(data)
                    print(dataList)

                }

                self.delegate?.manager(self, participantsItem: dataList)
            }
        })
    }
}



