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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 132/255, green: 180/255, blue: 255/255, alpha: 1)

        self.navigationController?.navigationBar.tintColor = UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1)


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



        userShowcase.layer.shadowColor = UIColor.black.cgColor
        userShowcase.layer.shadowRadius = 2
        userShowcase.layer.shadowOffset = CGSize(width: 0, height: 2)
        userShowcase.layer.shadowOpacity = 0.8

        self.headPhoto.layer.borderWidth = 1.5
        self.headPhoto.layer.borderColor = UIColor.black.cgColor
        self.headPhoto.layer.cornerRadius = 62.5
        self.headPhoto.clipsToBounds = true

        self.userHeadPhotoBase.layer.cornerRadius = 62.5



    }
    override func viewDidLayoutSubviews() {


        userShowcase.layer.cornerRadius = 12
        userShowcase.setTitleColor(UIColor.white, for: .normal)

        let setSaveHeadPhotoGradient = CAGradientLayer()
        setSaveHeadPhotoGradient.frame = userShowcase.bounds
        setSaveHeadPhotoGradient.colors = [UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1).cgColor, UIColor(red: 0/255, green: 85/255, blue: 216/255, alpha: 1).cgColor]
        setSaveHeadPhotoGradient.opacity = 0.85
        setSaveHeadPhotoGradient.startPoint = CGPoint(x: 0, y: 0)
        setSaveHeadPhotoGradient.endPoint = CGPoint(x: 1, y: 1)
        setSaveHeadPhotoGradient.cornerRadius = 12
        userShowcase.layer.insertSublayer(setSaveHeadPhotoGradient, at: 0)



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
