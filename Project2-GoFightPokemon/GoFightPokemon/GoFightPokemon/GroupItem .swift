//
//  GroupItem .swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase


struct GroupItem {

    var ownerId: String
    var gymLevel: String
    var bossName: String
    var childId: String
    var setTime: String
    var gymLocation: String

    init(snapshot: DataSnapshot) {

print("🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀")
        print(snapshot)
print("🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀🌀")
        let snapshotValue: [String: AnyObject] = snapshot.value as![String:AnyObject]

        self.ownerId = snapshotValue["ownerId"] as! String
        self.gymLevel = snapshotValue["gymLevel"] as! String
        self.bossName = snapshotValue["bossName"] as! String
        self.childId = snapshotValue["childId"] as! String
        self.setTime = snapshotValue["setTime"] as! String
        self.gymLocation = snapshotValue["gymLocation"] as! String

    }


}
