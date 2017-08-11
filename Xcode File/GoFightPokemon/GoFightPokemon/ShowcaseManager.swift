//
//  showcaseManager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/6.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol ShowcaseDelegate: class {

    func manager(_ controller: ShowcaseManager, success: Bool)
    func manager(_ controller: ShowcaseManager, updatePhotoDic: [String:Any])
}

class ShowcaseManager {

    let uid = Auth.auth().currentUser?.uid

    weak var delegate: ShowcaseDelegate?

    func setShowcaseItem(playerPokemonImage: [UIImage]) {

        Database.database().reference().child("usersShowcase").child(self.uid!).child("pokemonPhoto").removeValue { (error, _) in
            if error != nil {
                print(error!)
                return
            }

            print("remove data success...")
        }

        for image in playerPokemonImage {

            let uniqueString = NSUUID().uuidString

            let storageRef = Storage.storage().reference().child("userPhoto").child(uid!).child("userPokemon").child("\(uniqueString).png")

            if let uploadData = UIImagePNGRepresentation(image) {

                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in

                    if error != nil {

                        print("Error: \(error!.localizedDescription)")


                        return
                    }

                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {

                        print("Photo Url: \(uploadImageUrl)")

                        let dataBaseRef = Database.database().reference().child("usersShowcase").child(self.uid!).child("pokemonPhoto")

                        let childRef = dataBaseRef.childByAutoId()

                        childRef.setValue(uploadImageUrl, withCompletionBlock: { (error, _) in

                            if error != nil {

                                print("Database Error: \(error!.localizedDescription)")
                            } else {

                                print("picture has saved")
                                self.delegate?.manager(self, success: true)
                            }
                        }
                        )}
                }
                )}
        }

    }

    func getShowcaseItem () {

        //取下之前存在fireBase圖檔的url
        let dataBaseRef = Database.database().reference().child("usersShowcase").child(self.uid!).child("pokemonPhoto")

        var uploadPhotoDic: [String: Any]?

        dataBaseRef.observe(.value, with: { [weak self] (snapshot) in

            if let uploadDataDic = snapshot.value as? [String:Any] {

                uploadPhotoDic = uploadDataDic

                self?.delegate?.manager(self!, updatePhotoDic: uploadPhotoDic!)

            }
        })

    }

}
