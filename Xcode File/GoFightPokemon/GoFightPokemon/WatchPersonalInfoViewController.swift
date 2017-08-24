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

    @IBAction func editUserInfo(_ sender: Any) {

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let nextVC = storyBoard.instantiateViewController(withIdentifier: "PersonInfoViewController")
        present(nextVC, animated: true, completion: nil)

    }


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
    self.teamBadge.image = #imageLiteral(resourceName: "ice")
    case "火焰鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "fire")
    case "閃電鳥隊":
    self.teamBadge.image = #imageLiteral(resourceName: "lightening")
    default:
    self.teamBadge.image = #imageLiteral(resourceName: "leaf")

        teamBadge.contentMode = .scaleAspectFill
    }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        personManager.delegate = self
        personManager.getPersonItem()

        headPhotoManager.delegate = self
        headPhotoManager.getHeadPhoto()

        nickName.layer.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1).cgColor
        nickName.textColor = UIColor.white
        nickName.layer.cornerRadius = 10

        teamSelect.layer.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1).cgColor
        teamSelect.textColor = UIColor.white
        teamSelect.layer.cornerRadius = 10

        levelSelect.layer.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1).cgColor
        levelSelect.textColor = UIColor.white
        levelSelect.layer.cornerRadius = 10

        gymLevelSelect.layer.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1).cgColor
        gymLevelSelect.textColor = UIColor.white
        gymLevelSelect.layer.cornerRadius = 10


        userShowcase.layer.borderWidth = 1.5
        userShowcase.layer.borderColor = UIColor.blue.cgColor
        userShowcase.layer.cornerRadius = 10

        userShowcase.layer.shadowColor = UIColor.black.cgColor
        userShowcase.layer.shadowRadius = 2
        userShowcase.layer.shadowOffset = CGSize(width: 0, height: 2)
        userShowcase.layer.shadowOpacity = 0.8

        self.headPhoto.layer.borderWidth = 1.5
        self.headPhoto.layer.borderColor = UIColor.gray.cgColor
        self.headPhoto.layer.cornerRadius = 62.5
        self.headPhoto.clipsToBounds = true

        self.userHeadPhotoBase.layer.cornerRadius = 62.5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
