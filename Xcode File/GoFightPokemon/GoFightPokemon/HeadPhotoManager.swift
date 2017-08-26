//
//  HeadPhotoMmanager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/6.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol HeadPhotoDelegate: class {
    func manager(_ controller: HeadPhotoManager, success: Bool)
    func manager(_ controller: HeadPhotoManager, headPhoto: UIImage)
}

class HeadPhotoManager {


    let uid = Auth.auth().currentUser?.uid

    weak var delegate: HeadPhotoDelegate?

    func setHeadPhoto(headPhoto: UIImage?) {

        //儲存相簿選擇的照片到fireBase

        // 當selectedPhoto有東西時，將照片上傳

        //判定如果image 為預設原圖不要上傳

        if headPhoto != #imageLiteral(resourceName: "head_photo") {

            if let selectedPhoto = headPhoto {

                let uniqueString = NSUUID().uuidString

                // 設定storage 儲存位置,將圖片上傳

                let storageRef = Storage.storage().reference().child("userPhoto").child(uid!).child("userHead").child("\(uniqueString).png")

                print("🍶🍶🍶🍶🍶")

                //接收回傳的資料,記得要轉jpeg而非png，因為png不會保留圖片方向，拍照呈現時可能會轉90度
                if let uploadData =  UIImageJPEGRepresentation(selectedPhoto, 0.5) {
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
                            dataBaseRef.setValue(uploadImageUrl, withCompletionBlock: { (error, _) in

                                if error != nil {
                                    print("Database Error: \(error!.localizedDescription)")
                                } else {

                                    print("picture has saved")
                                    self.delegate?.manager(self, success: true)
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

    func getHeadPhoto() {
    //如果用戶已存過用戶照片，下載fireBase上的用戶照片的網址
    Database.database().reference().child("users").child(uid!).child("headPhoto").observe(.value, with: { (snapshot) in

        print(snapshot)
        var headPhoto: UIImage?

        if let uploaPhoto = snapshot.value as? String {

            //將照片網址解開，存入圖片放在imageView上

            if let imageUrl = URL(string: uploaPhoto) {

                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, _, error) in

                    if error != nil {

                        print("Download Image Task Fail: \(error!.localizedDescription)")

                    } else if let imageData = data {
                        DispatchQueue.main.async {

                            headPhoto = UIImage(data: imageData)
                            self.delegate?.manager(self, headPhoto: headPhoto!)

                        }

                    }

                }).resume()

            }
        }

    })

    }

    func getOtherPersonHeadPhoto(userId: String) {

        Database.database().reference().child("users").child(userId).child("headPhoto").observe(.value, with: { (snapshot) in

            print(snapshot)
            var headPhoto: UIImage?

            if let uploaPhoto = snapshot.value as? String {

                //將照片網址解開，存入圖片放在imageView上

                if let imageUrl = URL(string: uploaPhoto) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, _, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")

                        } else if let imageData = data {
                            DispatchQueue.main.async {

                                headPhoto = UIImage(data: imageData)

                                self.delegate?.manager(self, headPhoto: headPhoto!)

                            }

                        }

                    }).resume()

                }
            }

        })

    }

}
