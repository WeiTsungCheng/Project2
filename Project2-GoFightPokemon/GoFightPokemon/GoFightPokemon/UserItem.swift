//
//  UserItem.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/5.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Foundation
import Firebase


struct UserItem {

    var nickName: String
    var playerTeam: String
    var playerLevel: String
    var gymLevel: String
    var headPhoto: String

    var userId: String
    var userEmail: String

    init(snapshot: DataSnapshot) {

        print("🔰")
        print(snapshot)
        print("🔰")

        let snapshotValue: [String: AnyObject] = snapshot.value as![String:AnyObject]

        self.nickName = snapshotValue["nickName"] as! String
        self.playerTeam = snapshotValue["playerTeam"] as! String
        self.playerLevel = snapshotValue["playerLevel"] as! String
        self.gymLevel = snapshotValue["gymLevel"] as! String

        self.headPhoto = snapshotValue["headPhoto"] as! String

        self.userId = snapshotValue["userId"] as! String
        self.userEmail = snapshotValue["userEmail"] as! String
        

    
    
}
}
//let uid = Auth.auth().currentUser?.uid
////建立dataBase 資料庫結構
//let ref = Database.database().reference().child("users").child(uid!)
//
//var userData : [String : AnyObject] = [String : AnyObject]()
//userData["nickName"] = self.signUpNickName.text as AnyObject
//
//userData["headPhoto"] = "" as AnyObject
//userData["playerTeam"] = "" as AnyObject
//userData["playerLevel"] = "" as AnyObject
//userData["gymLevel"] = "" as AnyObject
//
//userData["userId"] = Auth.auth().currentUser?.uid as AnyObject
//userData["userEmail"] = Auth.auth().currentUser?.email as AnyObject
