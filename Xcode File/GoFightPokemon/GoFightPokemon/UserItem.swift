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
    var playerLevel: Int
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
        self.playerLevel = snapshotValue["playerLevel"] as! Int
        self.gymLevel = snapshotValue["gymLevel"] as! String

        self.headPhoto = snapshotValue["headPhoto"] as! String

        self.userId = snapshotValue["userId"] as! String
        self.userEmail = snapshotValue["userEmail"] as! String

}
}
