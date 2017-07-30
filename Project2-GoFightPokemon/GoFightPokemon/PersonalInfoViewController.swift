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

    var fireUploadDic: String?

    @IBOutlet weak var headPhoto: UIImageView!

//////
        func getHeadPhotoImage() {
    
            if let dataDic = fireUploadDic {

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

//////
   

    @IBAction func getPhotoFromLocal(_ sender: Any) {


        // 建立一個UIAlertController 的實體
        let photoImagePickerController = UIImagePickerController()

        photoImagePickerController.delegate = self

        // 設定 UIAlertController 的style為 actionSheet
        let photoAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的頭像圖片", preferredStyle: UIAlertControllerStyle.actionSheet)


        //製造三個 UIAlertAction實體
        let photoFromLibraryAction = UIAlertAction(title: "照片圖庫", style: UIAlertActionStyle.default) {(Void) in

            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                photoImagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(photoAlertController, animated: true, completion: nil)
            }
        }


        let photoFromCameraAction = UIAlertAction(title: "拍照取得", style: UIAlertActionStyle.default) {(Void) in

            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                    photoImagePickerController.sourceType = UIImagePickerControllerSourceType.camera

                self.present(photoAlertController, animated: true, completion: nil)
            }
        }

        let cancelAlertController = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (Void) in

            photoImagePickerController.dismiss(animated: true, completion: nil)
        }


        //將三個UIAlertAction實體 添加給 UIAlertController
        photoAlertController.addAction(photoFromLibraryAction)
        photoAlertController.addAction(photoFromCameraAction)
        photoAlertController.addAction(cancelAlertController)

        self.present(photoImagePickerController, animated: true, completion: nil)



    }

    override func viewDidLoad() {
        super.viewDidLoad()




        teamChoose.delegate = self
        teamSelect.inputView = teamChoose


        levelSelect.delegate = self


        gymLevelChoose.delegate = self
        gymLevelSelect.inputView = gymLevelChoose



/////

        let databaseRef = Database.database().reference().child("users").child("\(userID)").child("headPhoto")
        

        databaseRef.observe(.value, with: { [weak self] (snapshot) in

print("🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵")
                    print(snapshot)
print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")
                    if let uploadDataDic = snapshot.value as? String {

                        self?.fireUploadDic = uploadDataDic
                        self?.getHeadPhotoImage()

  print("⚪️⚪️⚪️⚪️⚪️⚪️⚪️⚪️")
                        print(self?.fireUploadDic ?? "🎁🎁🎁🎁🎁🎁")
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

    // 接從相片圖庫，或拍照取得的照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedPhotoFromPicker: UIImage?

        //取得從UIImagePickerController得到的photo
        if let pickedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        {

            selectedPhotoFromPicker = pickedPhoto

        }

        // 自動產生一個獨一無二的編碼，方便命名之後要上傳的圖片
        let uniqueString = NSUUID().uuidString




        // 當selectedPhoto有東西時，將照片上傳
        if let selectedPhoto = selectedPhotoFromPicker {


            print("\(uniqueString), \(selectedPhoto)")

            // 設定storage 儲存位置,將圖片上傳
            let storageRef = Storage.storage().reference().child("playerPhoto").child("headPhoto").child("\(uniqueString).png")

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
                        let dataBaseRef = Database.database().reference().child("users").child("\(userID)").child("headPhoto").child(uniqueString)

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


