//
//  WatchPersonalInfoViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/1.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class WatchPersonalInfoViewController: UIViewController, PersonDelegate, HeadPhotoDelegate {


    @IBOutlet weak var userHeadPhotoBase: UIView!
    @IBOutlet weak var userShowcase: UIButton!

    let personManager = PersonManager()

    let headPhotoManager = HeadPhotoManager()


    var getItems : UserItem?


    func manager(_ controller: PersonManager, success: Bool) {

    }
    func manager(_ controller: PersonManager) {

    }
    func manager(_ controller: PersonManager, userItem: UserItem) {

        getItems = userItem

        self.teamSelect.text = getItems?.playerTeam
        self.nickName.text = getItems?.nickName
        self.gymLevelSelect.text = getItems?.gymLevel

        if let thePlayerLevel = getItems?.playerLevel  {
             self.levelSelect.text = String(describing: thePlayerLevel)
        }

        selectTeamBadge()

    }

    func manager(_ controller: HeadPhotoManager, success: Bool) {

    }
    func manager(_ controller: HeadPhotoManager, headPhoto: UIImage) {

        DispatchQueue.main.async {

            self.headPhoto.image = headPhoto
            self.headPhoto.contentMode = UIViewContentMode.scaleAspectFill

        }

    }

    @IBOutlet weak var nickName: UILabel!

    @IBOutlet weak var teamSelect: UILabel!
    @IBOutlet weak var levelSelect: UILabel!
    @IBOutlet weak var gymLevelSelect: UILabel!

    @IBOutlet weak var headPhoto: UIImageView!

    @IBOutlet weak var teamBadge: UIImageView!

    func selectTeamBadge() {

    switch self.teamSelect.text! {


    case "急凍鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "if_Pokemon_Go-16_1320025")
    case "火焰鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "if_Pokemon_Go-15_1320026")
    case "閃電鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "if_Pokemon_Go-11_1320030")
    default:
    self.teamBadge.image = #imageLiteral(resourceName: "if__Pokeballs_1337535")

        teamBadge.contentMode = .scaleAspectFill
    }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        personManager.delegate = self

        personManager.getPersonItem()

        headPhotoManager.delegate = self

        headPhotoManager.getHeadPhoto()

        userShowcase.layer.borderWidth = 2.5
        userShowcase.layer.borderColor = UIColor.brown.cgColor
        userShowcase.backgroundColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        userShowcase.setTitleColor(UIColor(red: 86/255, green: 50/255, blue: 18/255, alpha: 1)
            , for: .normal)
        userShowcase.layer.cornerRadius = 10



        self.headPhoto.layer.borderWidth = 1.5
        self.headPhoto.layer.borderColor = UIColor(red: 65/255, green: 117/255, blue: 5/255, alpha: 1).cgColor
        self.userHeadPhotoBase.layer.cornerRadius = 62.5
        self.headPhoto.layer.cornerRadius = 62.5

        self.headPhoto.clipsToBounds = true



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
