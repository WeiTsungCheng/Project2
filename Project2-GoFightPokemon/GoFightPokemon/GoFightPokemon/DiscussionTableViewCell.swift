//
//  DiscussionTableViewCell.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class DiscussionTableViewCell: UITableViewCell {

    @IBOutlet weak var putComment: UITextView!

    @IBOutlet weak var playerNickName: UILabel!
    @IBOutlet weak var playerTeam: UILabel!
    @IBOutlet weak var playerLevel: UILabel!

    @IBOutlet weak var playerPhoto: UIImageView!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
