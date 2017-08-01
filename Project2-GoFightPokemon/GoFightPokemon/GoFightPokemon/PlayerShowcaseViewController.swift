//
//  playerShowcaseViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/31.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class PlayerShowcaseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let uid = Auth.auth().currentUser?.uid

    //存放用戶存檔前所選的圖片
    var playerPokemonImage: [UIImage] = [UIImage]()
    //存放用戶從fireBases拿下來的圖片
    var playerPokemonImageFireBase: [UIImage] = [UIImage]()


    @IBOutlet weak var Photo: UIImageView!

    // 設定一個字典存filepbase取下的資料
    var uploadPhotoDic : [String: Any]?



    @IBAction func uploadPokemonImage(_ sender: Any) {

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

    @IBAction func saveUserPokemon(_ sender: Any) {



        for image in playerPokemonImage{

            let uniqueString = NSUUID().uuidString

            let storageRef = Storage.storage().reference().child("userPhoto").child(uid!).child("userPokemon").child("\(uniqueString).png")

            if let uploadData = UIImagePNGRepresentation(image) {

                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in

                    if error != nil {

                        print("Error: \(error!.localizedDescription)")

                        return
                    }

                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {

                        print("Photo Url: \(uploadImageUrl)")

                        let dataBaseRef = Database.database().reference().child("usersShowcase").child(self.uid!).child("pokemonPhoto")

                        let childRef = dataBaseRef.childByAutoId()

                        childRef.setValue(uploadImageUrl, withCompletionBlock: { (error, data) in

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
        }
    }

      //  let storageRef = Storage.storage().reference().child("userPhoto").child(uid!).child("userPokemon").child("\(uniqueString).png")






//                // 連結取得方式就是：data?.downloadURL()?.absoluteString。
//                if let uploadImageUrl = data?.downloadURL()?.absoluteString {
//
//                    // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
//                    print("Photo Url: \(uploadImageUrl)")
//
//                }
//
//            }
//
//            )}













    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {

        let size = Photo.image?.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: (size?.width)! * heightRatio, height: (size?.height)! * heightRatio)
        } else {
            newSize = CGSize(width: (size?.width)! * widthRatio,  height: (size?.height)! * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        Photo.image?.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }










    override func viewDidLoad() {
        super.viewDidLoad()


    //取下之前存在fireBase圖檔的url
        let dataBaseRef = Database.database().reference().child("usersShowcase").child(self.uid!).child("pokemonPhoto")




        dataBaseRef.observe(.value, with: { [weak self] (snapshot) in

            if let uploadDataDic = snapshot.value as? [String:Any] {

                self?.uploadPhotoDic = uploadDataDic
            }

            print("◻️")
            print(snapshot)
            print("♥️")

            if let dataDic = self?.uploadPhotoDic {

                let valueArray = Array(dataDic.values)

                for value in valueArray {


                    if let imageUrl = URL(string: value as! String) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")

                        }

                        else if let imageData = data {

                            DispatchQueue.main.async {

                                self?.playerPokemonImageFireBase.append(UIImage(data: imageData)!)
                                self?.collectionView.reloadData()

                            }
                            
                        }
                        
                    }).resume()
                }
            }

            }
        })




        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerShowcaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //取從手機取到的照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        // 取得從 UIImagePickerController 選擇的檔案
        if let pickedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {

            playerPokemonImage.append(pickedPhoto)

            print(playerPokemonImage.count, "🔵")
            self.dismiss(animated: true, completion: nil)

            self.collectionView.reloadData()
        }

    }
}


extension PlayerShowcaseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    //放資料在collectionView上
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return playerPokemonImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PlayerShowcaseCollectionViewCell

        cell.pokemonImage.image = playerPokemonImage[indexPath.row]


        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width / 2.2
        return CGSize(width: picDimension, height: picDimension)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 14.0
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
}






