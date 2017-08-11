//
//  participantsItem.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/11.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase

struct ParticipantsItem {

    var playerId: String

    init(snapshot: DataSnapshot) {

    print("🌐")

    print(snapshot)

    print("🌐")

    let snapshotValue: [String: AnyObject] = snapshot.value as![String:AnyObject]

    self.playerId = snapshotValue["playerId"] as! String

    }
}

