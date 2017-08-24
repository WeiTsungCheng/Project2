//
//  WatchPersonShowcaseViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/1.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class WatchPersonShowcaseViewController: UIViewController, ShowcaseDelegate {

    func manager(_ controller: ShowcaseManager, success: Bool) {

    }
    func manager(_ controller: ShowcaseManager, updatePhotoDic: [String:Any]) {

        photoDic = updatePhotoDic
        self.collectionView.reloadData()

    }
    let showcaseＭanager = ShowcaseManager()

    @IBAction func editUserShowcase(_ sender: Any) {

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PersonShowcaseViewController")
        present(nextVC, animated: true, completion: nil)
    }



    @IBOutlet weak var collectionView: UICollectionView!

    var playerPokemonImageFireBase: [UIImage] = [UIImage]()

    // 設定一個字典存filepbase取下的資料
    var photoDic: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        showcaseＭanager.delegate = self
        showcaseＭanager.getShowcaseItem()


        //////////////////////////////////////////////////////////////////////
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
        ///////////////////////////////////////////////////////////////////////

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

        if let dataDic = photoDic {

                return dataDic.count
        }



        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchCell", for: indexPath) as! WatchPersonShowcaseCollectionViewCell

        if let dataDic = photoDic {

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
                                cell.pokemonImage.clipsToBounds = true

                            }

                        }

                    }).resume()
                }
            }

        }

        return cell
    }

}
