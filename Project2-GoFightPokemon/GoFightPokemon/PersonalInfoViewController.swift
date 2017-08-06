//
//  PersonalInfoViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/27.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit


class PersonalInfoViewController: UIViewController, PersonDelegate, HeadPhotoDelegate {

    func manager(_ controller: PersonManager, success: Bool){

    }
    func manager(_ controller: PersonManager){

    }
    func manager(_ controller: PersonManager, userItem: UserItem){

    }


    func manager(_ controller: HeadPhotoManager, success: Bool){

    }
    func manager(_ controller: HeadPhotoManager, headPhoto: UIImage){

    }


    let personManager = PersonManager()
    let headPhotoManager = HeadPhotoManager()


    @IBAction func goBackFuncList(_ sender: Any) {

         dismiss(animated: true, completion: nil)
        
    }

//    let uid = Auth.auth().currentUser?.uid

    var teams = ["請選擇隊伍", "急凍鳥隊", "閃電鳥隊", "火焰鳥隊"]
    let gymLevelChoose = UIPickerView()

    var gymLavels = ["請選擇難度", "簡單", "普通", "困難", "極困難", "傳說" ]
    let teamChoose = UIPickerView()

    

    @IBOutlet weak var teamSelect: UITextField!
    @IBOutlet weak var levelSelect: UITextField!
    @IBOutlet weak var gymLevelSelect: UITextField!

    var fireUpload: String?

    @IBOutlet weak var nickName: UILabel!

    @IBOutlet weak var headPhoto: UIImageView!



    @IBAction func saveUserData(_ sender: Any) {

        //儲存textfield所填資料到firebase
        self.personManager.setValuePersonItem(teamSelect: teamSelect.text!, levelSelect: levelSelect.text!, gymLevelSelect: gymLevelSelect.text!)

        self.headPhotoManager.setHeadPhoto(headPhoto: headPhoto.image)

    }


    @IBAction func getPhotoFromLocal(_ sender: Any) {


        // 建立一個 UIImagePickerController 的實體
        let imagePickerController = UIImagePickerController()

        // 委任代理
        imagePickerController.delegate = self

        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)

        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in

            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in

            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {

                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }

        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in

            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }

        // 將上面三個 UIAlertAction 動作加入 UIAlertController
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true, completion: nil)
    }


    

    override func viewDidLoad() {
        super.viewDidLoad()

        teamChoose.delegate = self
        teamSelect.inputView = teamChoose


        levelSelect.delegate = self


        gymLevelChoose.delegate = self
        gymLevelSelect.inputView = gymLevelChoose

        personManager.delegate = self
        headPhotoManager.delegate = self


    }


 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}


extension PersonalInfoViewController :  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        var countthrow: Int = gymLavels.count

        if pickerView == teamChoose {


            countthrow = teams.count
        }

        return countthrow
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == teamChoose {

            let titleRow = teams[row]

            return titleRow

        }

        else if pickerView == gymLevelChoose {

            let titleRow = gymLavels[row]
            
            return titleRow
            
        }

        return ""

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == teamChoose {

            if row == 0 {
            teamSelect.text = ""
            }

            else {
            teamSelect.text = teams[row]
            }

        }

        if pickerView == gymLevelChoose {


            if row == 0 {
                gymLevelSelect.text = ""
            }

            else {
                gymLevelSelect.text = gymLavels[row]
            }

        }


  
    }
}


// 處裡UIPickerView(控制levelSelect 只能填入數字)
extension PersonalInfoViewController : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharcters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharcters.isSuperset(of: characterSet)
    }
    
    
}




//處理UIImagePickerControll
extension PersonalInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // 儲存相片圖庫取得的照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            headPhoto.image = image
        } else {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)

        headPhoto.contentMode = UIViewContentMode.scaleAspectFit

    }





}


