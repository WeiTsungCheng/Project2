//
//  ParticipantListViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/11.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class ParticipantListViewController: UIViewController, ParticipantsDelegate {

    func manager(_ controller: ParticipantManager, success: Bool){

    }

    func manager(_ controller: ParticipantManager, participantsItem: ParticipantsItem){

    }

    func manager(_ controller: ParticipantManager, participantsCount: Int){

    }

    func manager(_ controller: ParticipantManager, attendButton: Bool, cancelButton: Bool){

    }

    //接收DiscussionViewController 接收資料
    var childIdNameName = ""



    override func viewDidLoad() {
        super.viewDidLoad()

        print("🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼🇹🇼")
        print(childIdNameName)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
}



extension ParticipantListViewController: UITableViewDelegate, UITableViewDataSource {

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let Cell = tableView.dequeueReusableCell(withIdentifier: "PartivipantListCell", for: indexPath) as! ParticipantListTableViewCell

        return Cell

    }










}
