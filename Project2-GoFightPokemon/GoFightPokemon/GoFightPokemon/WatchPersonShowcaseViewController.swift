//
//  WatchPersonShowcaseViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/1.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class WatchPersonShowcaseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
 

    let uid = Auth.auth().currentUser?.uid

    var playerPokemonImageFireBase: [UIImage] = [UIImage]()

    // 設定一個字典存filepbase取下的資料
    var uploadPhotoDic : [String: Any]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //取下之前存在fireBase圖檔的url
        let dataBaseRef = Database.database().reference().child("usersShowcase").child(self.uid!).child("pokemonPhoto")

        dataBaseRef.observe(.value, with: { [weak self] (snapshot) in

            if let uploadDataDic = snapshot.value as? [String:Any] {

                self?.uploadPhotoDic = uploadDataDic
                self?.collectionView.reloadData()

                print("◻️")

                print(snapshot)

                print("♥️")

            }
            })
            





        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



extension WatchPersonShowcaseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    //放資料在collectionView上
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let dataDic = uploadPhotoDic {

            return dataDic.count
        }

        return 0
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchCell", for: indexPath) as! WatchPersonShowcaseCollectionViewCell

        if let dataDic = uploadPhotoDic {

            let keyArray = Array(dataDic.keys)

            if let imageUrlString = dataDic[keyArray[indexPath.row]] as? String {

                if let imageUrl = URL(string: imageUrlString) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")

                        }

                        else if let imageData = data {

                            DispatchQueue.main.async {

                                cell.pokemonImage.image = UIImage(data: imageData)

                            }
                            
                        }
                        
                    }).resume()
                }
            }
            
            
        }

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


