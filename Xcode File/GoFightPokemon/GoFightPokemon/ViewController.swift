//
//  ViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/26.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleWord: UILabel!

    @IBOutlet weak var loginPage: UIButton!
    @IBOutlet weak var signupPage: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleWord.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

        titleWord.shadowOffset = CGSize(width: 0, height: 1)

      

        loginPage.setTitleShadowColor(UIColor.black, for: .normal)

        loginPage.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        loginPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)



        signupPage.setTitleShadowColor(UIColor.black, for: .normal)

        signupPage.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        signupPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
