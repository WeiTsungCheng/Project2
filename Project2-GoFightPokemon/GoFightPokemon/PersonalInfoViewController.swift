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

        if let selectedPhoto = headPhoto.image {

            // 設定storage 儲存位置,將圖片上傳
            let storageRef = Storage.storage().reference().child("userPhoto").child(uid!).child("userHead")
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


    }





    @IBAction func getPhotoFromLocal(_ sender: Any) {

        // 建立一個UIAlertController 的實體
        let photoImagePickerController = UIImagePickerController()

        photoImagePickerController.delegate = self



        photoImagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary


        photoImagePickerController.allowsEditing = true



        self.present(photoImagePickerController, animated: true, completion: nil)
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


                //將照片網址解開，存入圖片放在imageView上

                if let imageUrl = URL(string: uploaPhoto) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")

                        }


                        else if let imageData = data {
                            DispatchQueue.main.async {

                                self?.headPhoto.image = UIImage(data: imageData)
                             //   self?.headPhoto.contentMode = UIViewContentMode.scaleAspectFit

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

        //不要把placehold預設圖像放的填滿控制放在viewDidLoad()下，否則剛進入頁面時會造成預設圖像模糊，而是放在拿完圖後（拍照,或相簿拿圖）,存入imageView時再改成scaleAspectFit，讓圖片撐開外面的scrollView
        headPhoto.contentMode = UIViewContentMode.scaleAspectFit






    }




}


