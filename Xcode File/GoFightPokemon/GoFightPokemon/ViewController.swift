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

    @IBAction func goSignupPage(_ sender: Any) {

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SignupViewController")
        let applicationDelegation = UIApplication.shared.delegate as? AppDelegate
        applicationDelegation?.window?.rootViewController = nextVC
    }

    @IBAction func goLoginPage(_ sender: Any) {

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        let applicationDelegation = UIApplication.shared.delegate as? AppDelegate
        applicationDelegation?.window?.rootViewController = nextVC
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginPageGradient = CAGradientLayer()
        loginPageGradient.frame = self.view.frame
        loginPageGradient.colors = [UIColor.green.cgColor, UIColor.white.cgColor]
        loginPageGradient.opacity = 0.7
        loginPageGradient.startPoint = CGPoint(x: 1, y: 0)
        loginPageGradient.endPoint = CGPoint(x: 0, y: 1)
        self.view.layer.insertSublayer(loginPageGradient, at: 0)

        titleWord.shadowColor = UIColor.white

        titleWord.shadowOffset = CGSize(width: 0, height: 3)

      

        loginPage.setTitleShadowColor(UIColor.white, for: .normal)
        loginPage.setTitleColor(UIColor.black, for: .normal)
        loginPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)






        signupPage.setTitleShadowColor(UIColor.white, for: .normal)
        signupPage.setTitleColor(UIColor.black, for: .normal)
        signupPage.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
