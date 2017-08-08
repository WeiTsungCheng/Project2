//
//  CommentManager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/6.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol DiscussionDelegate: class {

    func manager(_ controller: DiscussionManager, success: Bool)
    func manager(_ controller: DiscussionManager, groupItem: [DiscussionItem])
}

class DiscussionManager {

    var delegate: DiscussionDelegate? = nil

    func setDiscussionItem(writeComment: String, childId: String){

        if writeComment == "" {
            return
        }

        let reference : DatabaseReference! =
            Database.database().reference().child("groupComment").child(childId)

        let childRef = reference.childByAutoId()

        var discussion: [String: AnyObject] = [String: AnyObject]()

        //   discussion["ownerId"] = ownerId as AnyObject
        //   discussion["participantEmail"] = Auth.auth().currentUser?.email as AnyObject
        discussion["childId"] = childId as AnyObject
        discussion["participantId"] = Auth.auth().currentUser?.uid as AnyObject
        discussion["participantComment"] = writeComment as AnyObject

        let discussionReference = reference.child(childRef.key)
        discussionReference.updateChildValues(discussion) { (err, ref) in
            if err != nil {
                print("err \(err!)")
                return
            }

            print("✳️✳️✳️✳️✳️✳️✳️✳️")

            print(reference.description())
            self.delegate?.manager(self, success: true)
            
            print("✳️✳️✳️✳️✳️✳️✳️✳️")
        }

    }

    func getDiscussionItem(childId: String){

        //載入即時更新的comment
        let reference = Database.database().reference()

        reference.child("groupComment").child(childId).observe(.value , with: {(snapshot) in

            var getItem = [DiscussionItem]()

            if snapshot.childrenCount > 0 {

                print(snapshot.childrenCount)

                var datalist: [DiscussionItem] = [DiscussionItem]()

                for item in snapshot.children {

                    print("----------")
                    print(snapshot.children)

                    print("----------")

                    let data = DiscussionItem(snapshot: item as! DataSnapshot)
                    datalist.append(data)

                    print(datalist)

                }
                
                getItem = datalist
                self.delegate?.manager(self, groupItem: getItem)

            }
        })

    }




}
