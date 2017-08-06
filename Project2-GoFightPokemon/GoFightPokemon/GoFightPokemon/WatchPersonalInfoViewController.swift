//
//  WatchPersonalInfoViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/1.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase


class WatchPersonalInfoViewController: UIViewController, PersonDelegate {

    let personmanager = PersonManager()

    let uid = Auth.auth().currentUser?.uid

    var getItems: UserItem?

    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }
    func manager(_ controller: PersonManager, userItem: UserItem){
        getItems = userItem

        self.teamSelect.text = getItems?.playerTeam
        self.nickName.text = getItems?.nickName
        self.gymLevelSelect.text = getItems?.gymLevel
        self.levelSelect.text = getItems?.playerLevel

        selectTeamBadge()


    }

  
    @IBOutlet weak var nickName: UILabel!

    @IBOutlet weak var teamSelect: UILabel!
    @IBOutlet weak var levelSelect: UILabel!
    @IBOutlet weak var gymLevelSelect: UILabel!

    @IBOutlet weak var headPhoto: UIImageView!

    @IBOutlet weak var teamBadge: UIImageView!

    func selectTeamBadge(){

    switch self.teamSelect.text! {

    case "急凍鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-16-128")
    case "火焰鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-15-128")
    case "閃電鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-11-128")
    default:
    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-01-128")
    }

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        personmanager.delegate = self

        personmanager.getPersonItem()





        let reference = Database.database().reference().child("users").child(uid!)
//
//
//
//        // nickName 註冊時填入，註冊完成後不可改
//        reference.child("nickName").observe(.value, with: { (snapshot) in
//
//            if let uploadNickName = snapshot.value as? String {
//
//                self.nickName.text = uploadNickName
//                print(uploadNickName, "🔵")
//            }
//        })
//
//
//        reference.child("playerLevel").observe(.value, with: {(snapshot) in
//
//            if let uploadPlayerLevel = snapshot.value as? String {
//
//                self.levelSelect.text = uploadPlayerLevel
//                print(uploadPlayerLevel, "🔴")
//            }
//        })
//
//        reference.child("playerTeam").observe(.value, with: {(snapshot) in
//
//            if let uploadPlayerTeam = snapshot.value as? String {
//
//                self.teamSelect.text = uploadPlayerTeam
//
//                switch self.teamSelect.text! {
//
//                case "急凍鳥隊":
//                    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-16-128")
//                case "火焰鳥隊":
//                    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-15-128")
//                case "閃電鳥隊":
//                    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-11-128")
//                default:
//                    self.teamBadge.image = #imageLiteral(resourceName: "Pokemon_Go-01-128")
//                }
////
//
//                print(uploadPlayerTeam, "⚪️")
//
//            }
//        })
//
//        reference.child("gymLevel").observe(.value, with: {(snapshot) in
//
//            if let uploadGymLevel = snapshot.value as? String {
//
//                self.gymLevelSelect.text = uploadGymLevel
//            }
//        })

        //如果用戶已存過用戶照片，下載fireBase上的用戶照片的網址
        reference.child("headPhoto").observe(.value, with: { [weak self] (snapshot) in


            print(snapshot)



            if let uploaPhoto = snapshot.value as? String {


                //將照片網址解開，存入圖片放在imageView上

                if let imageUrl = URL(string: uploaPhoto) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")

                        }


                        else if let imageData = data {
                            DispatchQueue.main.async {
                                
                                self?.headPhoto.image = UIImage(data: imageData)
                                self?.headPhoto.contentMode = UIViewContentMode.scaleAspectFit
                                
                            }
                            
                        }
                        
                    }).resume()
                    
                }
            }
            
        })




        
    }
    


        // Do any additional setup after loading the view.


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
