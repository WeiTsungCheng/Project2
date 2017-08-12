//
//  ParticipantListTableViewCell.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/11.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class ParticipantListTableViewCell: UITableViewCell {

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var playerTeam: UILabel!
    @IBOutlet weak var playerLevel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
