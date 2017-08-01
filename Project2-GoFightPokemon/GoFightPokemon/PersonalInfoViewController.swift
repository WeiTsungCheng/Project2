//
//  PersonalInfoViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/27.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class PersonalInfoViewController: UIViewController {
    let uid = Auth.auth().currentUser?.uid

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
        if let team = teamSelect.text {

            let dataBaseRef = Database.database().reference().child("users").child(uid!).child("playerTeam")

            dataBaseRef.setValue(team, withCompletionBlock: { (error, data) in

                if error != nil {

                    print("Database Error: \(error!.localizedDescription)")
                }
                else {
                    print("team has saved")
                }
            }
            )
        }


        if let pLevel = levelSelect.text {

            let dataBaseRef = Database.database().reference().child("users").child(uid!).child("playerLevel")

            dataBaseRef.setValue(pLevel, withCompletionBlock: { (error, data) in

                if error != nil {

                    print("Database Error: \(error!.localizedDescription)")
                }
                else {
                    print("playerLevel has saved")
                }
            }
            )
        }


        if let gLevel = gymLevelSelect.text {

            let dataBaseRef = Database.database().reference().child("users").child(uid!).child("gymLevel")

            dataBaseRef.setValue(gLevel, withCompletionBlock: { (error, data) in

                if error != nil {

                    print("Database Error: \(error!.localizedDescription)")
                }
                else {
                    print("challengeLevel has saved")
                }
            }
            )
        }

        //儲存相簿選擇的照片到fireBase
        // 當selectedPhoto有東西時，將照片上傳
        //判定如果image 為預設原圖不要上傳  icons8-Lion Head Filled-50
        if headPhoto.image != #imageLiteral(resourceName: "icons8-Lion Head Filled-50") {


        if let selectedPhoto = headPhoto.image {


            let uniqueString = NSUUID().uuidString
            // 設定storage 儲存位置,將圖片上傳
            let storageRef = Storage.storage().reference().child("userPhoto").child(uid!).child("userHead").child("\(uniqueString).png")
            //接收回傳的資料




            if let uploadData = UIImagePNGRepresentation(selectedPhoto) {

                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in

                    // 若發生錯誤
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }

                    // 接收回傳的圖片網址位置
                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {

                        print ("photo url: \(uploadImageUrl)")

                        // 儲存網址到dataBase上
                        let dataBaseRef = Database.database().reference().child("users").child(self.uid!).child("headPhoto")

                        dataBaseRef.setValue(uploadImageUrl, withCompletionBlock: { (error, data) in

                            if error != nil {

                                print("Database Error: \(error!.localizedDescription)")
                            }
                            else {
                                
                                print("picture has saved")
                            }

                        }
                        )}
                }
                )}

           print("didn't pick picture")

            }


        } else {
            print("It is a origin photo")
        }



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



        //如果用戶已存過用戶資料，下載fireBase上的用戶資料，填入textfield
        let reference = Database.database().reference().child("users").child(uid!)



        // nickName 註冊時填入，註冊完成後不可改
        reference.child("nickName").observe(.value, with: { (snapshot) in

            if let uploadNickName = snapshot.value as? String {

                self.nickName.text = uploadNickName
                print(uploadNickName, "🔵")
            }
        })


        reference.child("playerLevel").observe(.value, with: {(snapshot) in

            if let uploadPlayerLevel = snapshot.value as? String {

                self.levelSelect.text = uploadPlayerLevel
                print(uploadPlayerLevel, "🔴")
            }
        })

        reference.child("playerTeam").observe(.value, with: {(snapshot) in

            if let uploadPlayerTeam = snapshot.value as? String {

                self.teamSelect.text = uploadPlayerTeam
                print(uploadPlayerTeam, "⚪️")

            }
        })

        reference.child("gymLevel").observe(.value, with: {(snapshot) in

            if let uploadGymLevel = snapshot.value as? String {

                self.gymLevelSelect.text = uploadGymLevel
            }
        })

        //如果用戶已存過用戶照片，下載fireBase上的用戶照片的網址
        reference.child("headPhoto").observe(.value, with: { [weak self] (snapshot) in

print("🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵")
            print(snapshot)
print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")


            if let uploaPhoto = snapshot.value as? String {

print("⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️")
                //將照片網址解開，存入圖片放在imageView上

                if let imageUrl = URL(string: uploaPhoto) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")

                        }


                        else if let imageData = data {
                            DispatchQueue.main.async {

                                self?.headPhoto.image = UIImage(data: imageData)
                                self?.headPhoto.contentMode = UIViewContentMode.scaleAspectFit

                            }

                        }

                    }).resume()

                }
            }

        })

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


