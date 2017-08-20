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
    @IBOutlet weak var collectionView: UICollectionView!

    func manager(_ controller: ShowcaseManager, success: Bool){

    }

    func manager(_ controller: ShowcaseManager, updatePhotoDic: [String:Any]){
        photoDic = updatePhotoDic

        

        collectionView.reloadData()
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

        OtherPlayerNickName.text = nickNameName + "的展示間:"

/////////////////////////////////////////////////////
        let layout = UICollectionViewFlowLayout()

        let lowerFrameHeight = self.collectionView.frame.height

        layout.itemSize = CGSize(width: 129, height: 183)

        print(lowerFrameHeight)

        let separatorSpace = (lowerFrameHeight - 183 * 2 - 10)/2

        print(separatorSpace)

        layout.sectionInset = UIEdgeInsets(top: separatorSpace, left: 20, bottom: separatorSpace, right: 7)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
/////////////////////////////////////////////////////

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
    extension OtherShowcaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{



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
                                    cell.pokemonImage.contentMode = .scaleAspectFill
                                    
                                }
                                
                            }
                            
                        }).resume()
                    }
                }
                
            }

            return cell

        }
        





    }



