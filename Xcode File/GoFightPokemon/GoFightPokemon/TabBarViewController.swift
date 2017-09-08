//
//  TabBarViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/25.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.unselectedItemTintColor = UIColor.black
        self.tabBar.tintColor = UIColor.white

        UITabBar.appearance().barTintColor = UIColor.prjDarkSkyBlue
///dsaesaf
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
