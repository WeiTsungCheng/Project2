//
//  PersonalInfoViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/27.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class PersonalInfoViewController: UIViewController {


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

//////

    func getHeadPhotoImage() {
    

        if let dataDic = fireUpload {


            if let imageUrl = URL(string: dataDic) {
    

                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
    

                    if error != nil {


                        print("Download Image Task Fail: \(error!.localizedDescription)")
                            }

                    else if let imageData = data {
    

                        DispatchQueue.main.async {
    


                            self.headPhoto.image = UIImage(data: imageData)


                            self.headPhoto.contentMode = UIViewContentMode.scaleAspectFit
                        }
                    }
                }).resume()
            }
        }

    }
/////
///////////////////////////////

    @IBAction func saveUserData(_ sender: Any) {

        if let team = teamSelect.text {

            let dataBaseRef = Database.database().reference().child("users").child(autoID).child("playerTeam")

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

            let dataBaseRef = Database.database().reference().child("users").child(autoID).child("playerLevel")

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

            let dataBaseRef = Database.database().reference().child("users").child(autoID).child("gymLevel")

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



    }

///////////////////////////////



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

//////////////////////////////////////////////////////
        let reference = Database.database().reference().child("users").child(autoID).child("nickName")


        reference.observe(.value, with: { [weak self] (snapshot) in

            if let uploadData = snapshot.value as? String {

                self?.nickName.text = uploadData

            }
            
        })
//////////////////////////////////////////////////////


/////

        let ref = Database.database().reference().child("users").child(autoID).child("headPhoto")


        ref.observe(.value, with: { [weak self] (snapshot) in

print("🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵")
            print(snapshot)
print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")

            if let uploadData = snapshot.value as? String {

                self?.fireUpload = uploadData
                self?.getHeadPhotoImage()

print("⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️")
                print(self?.fireUpload ?? "")
print("⚫️⚫️⚫️⚫️⚫️⚫️⚫️⚫️")
            }

        })


/////








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

    // 接從相片圖庫取得的照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedPhotoFromPicker: UIImage?

        //取得從UIImagePickerController得到的photo
        if let pickedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        {

            selectedPhotoFromPicker = pickedPhoto

        }



        // 當selectedPhoto有東西時，將照片上傳
        if let selectedPhoto = selectedPhotoFromPicker {

            // 設定storage 儲存位置,將圖片上傳
            let storageRef = Storage.storage().reference().child("userPhoto").child("head")
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
                        let dataBaseRef = Database.database().reference().child("users").child(autoID).child("headPhoto")

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




            self.dismiss(animated: true, completion: nil)



        }


    }




}


