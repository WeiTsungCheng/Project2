//
//  OtherShowcaseViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/13.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class OtherShowcaseViewController: UIViewController, ShowcaseDelegate {
    @IBOutlet weak var OtherPlayerNickName: UILabel!

    @IBOutlet weak var collectoinView: UICollectionView!
    func manager(_ controller: ShowcaseManager, success: Bool){

    }

    func manager(_ controller: ShowcaseManager, updatePhotoDic: [String:Any]){
        photoDic = updatePhotoDic

        

        collectoinView.reloadData()
    }

    let showcaseManager = ShowcaseManager()
    var photoDic: [String: Any]?

    //接收傳值
    var userIdName = ""
    var nickNameName = ""





    override func viewDidLoad() {
        super.viewDidLoad()

        showcaseManager.delegate = self
        showcaseManager.getOtherPlayerShowcaseItem(playerId: userIdName)

        OtherPlayerNickName.text = nickNameName + "的展覽室"


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
    extension OtherShowcaseViewController: UICollectionViewDelegate, UICollectionViewDataSource {



        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            if let dataDic = photoDic {
                print("🍔🍔🍔🍔🍔🍔🍔🍔🍔🍔🍔🍔🍔")

                return dataDic.count
            }

            return 0
        }


        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherShowcaseCell", for: indexPath) as! OtherShowcaseCollectionViewCell

            if let dataDic = photoDic {

                print("🍔🍔🍔🍔🍔")
                let keyArray = Array(dataDic.keys)

                if let imageUrlString = dataDic[keyArray[indexPath.row]] as? String {

                    if let imageUrl = URL(string: imageUrlString) {

                        URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, _, error) in

                            if error != nil {

                                print("Download Image Task Fail: \(error!.localizedDescription)")

                            } else if let imageData = data {

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
        





    }



