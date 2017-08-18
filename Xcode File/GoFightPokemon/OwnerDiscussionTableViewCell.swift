//
//  OwnerDiscussionTableViewCell.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/5.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class OwnerDiscussionTableViewCell: UITableViewCell {


    @IBOutlet weak var ownerPhotoBase: UIView!
    @IBOutlet weak var ownerPhoto: UIImageView!
    @IBOutlet weak var putComment: UITextView!


    @IBOutlet weak var ownerNickName: UILabel!

    @IBOutlet weak var ownerTeam: UILabel!

    @IBOutlet weak var ownerLevel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
