//
//  DiscussionViewController.swift
//  
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DiscussionViewController: UIViewController {

    let uid = Auth.auth().currentUser?.uid

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var gymLevel: UILabel!
    @IBOutlet weak var bossName: UILabel!

    @IBOutlet weak var writeComment: UITextView!




    //設定新變數為了從GroupListTabaleView傳值過來
    var gymLevelName = ""
    var bossNameName = ""
    var childIdName = ""
    var ownerIdName = ""

    var reference: DatabaseReference?
    var getItem: [DiscussionItem] = []
    var personItem : [PersonItem] = []






    @IBAction func sendComment(_ sender: Any) {

        let childId = childIdName

     //   let ownerId = ownerIdName

        if self.writeComment.text == "" {
            return
        }

        let reference : DatabaseReference! =
                Database.database().reference().child("groupComment").child("\(childId)")

        let childRef = reference.childByAutoId()

        var discussion: [String: AnyObject] = [String: AnyObject]()

     //   discussion["ownerId"] = ownerId as AnyObject
     //   discussion["participantEmail"] = Auth.auth().currentUser?.email as AnyObject
        discussion["childId"] = childId as AnyObject
        discussion["participantId"] = Auth.auth().currentUser?.uid as AnyObject
        discussion["participantComment"] = writeComment.text as AnyObject

        let discussionReference = reference.child(childRef.key)
        discussionReference.updateChildValues(discussion) { (err, ref) in
            if err != nil {
                print("err \(err!)")
                return
            }

            print("✳️✳️✳️✳️✳️✳️✳️✳️")

            print(reference.description())

            print("✳️✳️✳️✳️✳️✳️✳️✳️")
        }

    }




    override func viewDidLoad() {
        super.viewDidLoad()

        //從GroupListTableViewCell傳值過來
        gymLevel.text = gymLevelName
        bossName.text = bossNameName
        let childId = childIdName

        //載入即時更新的comment
      let reference = Database.database().reference()

        reference.child("groupComment").child("\(childId)").observe(.value , with: {(snapshot) in

            print(snapshot)

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

                self.getItem = datalist
                print(self.getItem)
                self.tableView.reloadData()
            }
        })


        //取player個人資料

/////////

       reference.child("users").observe(.value, with: {(snapshot) in

            print(snapshot)

        if snapshot.childrenCount > 0 {

            var datalist: [PersonItem] = [PersonItem]()


            for item in snapshot.children {
                    let data = PersonItem(snapshot: item as! DataSnapshot)
                    datalist.append(data)


                    print(datalist)
                    self.personItem = datalist

                self.tableView.reloadData()
                

                    
                }


        

                
            }
            
        })

//////////

        




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension DiscussionViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionCell", for: indexPath) as! DiscussionTableViewCell

        cell.putComment.text = getItem[indexPath.row].participantComment

        cell.playerNickName.text =  personItem[indexPath.row].nickName
        cell.playerLevel.text = personItem[indexPath.row].playerLevel
        cell.playerTeam.text = personItem[indexPath.row].playerTeam



        return cell
    }



}









