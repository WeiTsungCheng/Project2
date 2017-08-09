//
//  GroupSetViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/2.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GroupSetViewController: UIViewController, GroupDelegate {





    func manager(_ controller: GroupManager, success: Bool){

    }
    func manager(_ controller: GroupManager, groupItem: [GroupItem]){

    }

    let setGroupManager = GroupManager()


    @IBOutlet weak var gymLevel: UITextField!

    @IBOutlet weak var bossName: UITextField!

    var gymLavels = ["請選擇難度", "簡單", "普通", "困難", "極困難", "傳說"]
    let gymLevelChoose = UIPickerView()


    @IBAction func groupSet(_ sender: UIButton) {

        setGroupManager.setGroupItem(gymLevel: gymLevel.text!, bossName: bossName.text!, setTime: setTime.text!)


        self.navigationController?.popViewController(animated: true)

    }


    @IBOutlet weak var setTime: UITextField!


    func datePickerValueChanged(sender: UIDatePicker) {

        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.short
        setTime.text = formatter.string(from: sender.date)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gymLevelChoose.delegate = self
        gymLevel.inputView = gymLevelChoose

        setGroupManager.delegate = self

        let gymTimePicker = UIDatePicker()
        gymTimePicker.datePickerMode = UIDatePickerMode.dateAndTime
        gymTimePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        setTime.inputView = gymTimePicker





    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}


extension GroupSetViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return gymLavels.count

    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        let titleRow = gymLavels[row]

        return titleRow

    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {


        if row == 0 {

            gymLevel.text = ""

        }

        else {

            gymLevel.text = gymLavels[row]
        }
                

    }



}

