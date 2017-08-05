//
//  PersonItem.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/5.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase

struct PersonItem {

    var playerLevel: String

    var nickName : String

    var playerTeam: String

    var headPhoto: String

    init(snapshot: DataSnapshot) {

        print("⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
        print(snapshot)
        print("⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
        let snapshotValue: [String: AnyObject] = snapshot.value as![String:AnyObject]

        self.playerLevel = snapshotValue["playerLevel"] as! String
        self.nickName = snapshotValue["nickName"] as! String
        self.playerTeam = snapshotValue["playerTeam"] as! String
        self.headPhoto = snapshotValue["headPhoto"] as! String
        
    }
    
    
}

