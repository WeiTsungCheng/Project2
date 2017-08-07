//
//  WatchPersonalInfoViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/1.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class WatchPersonalInfoViewController: UIViewController, PersonDelegate, HeadPhotoDelegate {

    let personManager = PersonManager()
    let headPhotoManager = HeadPhotoManager()

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

    func manager(_ controller: HeadPhotoManager, success: Bool){

    }
    func manager(_ controller: HeadPhotoManager, headPhoto: UIImage){

        DispatchQueue.main.async {

            self.headPhoto.image = headPhoto
            self.headPhoto.contentMode = UIViewContentMode.scaleAspectFit

        }

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

        personManager.delegate = self

        personManager.getPersonItem()

        headPhotoManager.delegate = self

        headPhotoManager.getHeadPhoto()



    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
