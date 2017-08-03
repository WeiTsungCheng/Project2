//
//  DiscussionItem.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/3.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase

struct DiscussionItem {

    var childId: String
    var participantId: String
    var participantComment: String

    init(snapshot: DataSnapshot) {

        print(snapshot)

        let snapshotValue: [String: AnyObject] = snapshot.value as![String: AnyObject]

        self.childId = snapshotValue["childId"] as! String
        self.participantId = snapshotValue["participantId"] as! String
        self.participantComment = snapshotValue["participantComment"] as! String
        

    }



}
