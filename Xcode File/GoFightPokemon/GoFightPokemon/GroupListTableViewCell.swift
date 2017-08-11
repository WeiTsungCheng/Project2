//
//  GroupListTableViewCell.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class GroupListTableViewCell: UITableViewCell {

    @IBOutlet weak var gymLevel: UILabel!

    @IBOutlet weak var bossName: UILabel!

    @IBOutlet weak var setTime: UILabel!

    @IBOutlet weak var ownerNickName: UILabel!

    @IBOutlet weak var gymLocation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
