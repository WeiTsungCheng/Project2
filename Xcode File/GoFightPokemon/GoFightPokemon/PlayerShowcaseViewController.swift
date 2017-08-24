//
//  playerShowcaseViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/31.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class PlayerShowcaseViewController: UIViewController, ShowcaseDelegate {

    @IBOutlet weak var uploadPokemon: UIButton!

    @IBOutlet weak var cancelPokemon: UIButton!

    @IBOutlet weak var savePokemon: UIButton!

    @IBAction func backUserShowcase(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }
    @IBOutlet weak var backShowcase: UIButton!


    @IBOutlet weak var collectionView: UICollectionView!

    func manager(_ controller: ShowcaseManager, success: Bool) {

    }
    func manager(_ controller: ShowcaseManager, updatePhotoDic: [String:Any]) {

    }

    let showcaseManager = ShowcaseManager()

    //存放用戶存檔前所選的圖片
    var playerPokemonImage: [UIImage] = [UIImage]()

    //deletePokemonAct方法為移除 playerPokemonImage 陣列中特定的值
    @IBAction func deletePokemonAct(_ sender: UIButton) {

        //sender將button的標籤數字傳過來，即得到當前所取的cell位置
        playerPokemonImage.remove(at: sender.tag)

        collectionView.reloadData()
    }

    @IBAction func cancelImg(_ sender: Any) {
        playerPokemonImage = [UIImage]()

        self.collectionView.reloadData()
    }

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
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (_) in

            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (_) in

            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {

                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }

        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in

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


        let alertController = UIAlertController(title: "確認", message: "確認更新你的展示間？", preferredStyle: .alert)


        let comfirmAlertAction = UIAlertAction(title: "確認", style: .default, handler: { (action: UIAlertAction) -> () in

               self.showcaseManager.setShowcaseItem(playerPokemonImage: self.playerPokemonImage)

            self.dismiss(animated: true, completion: nil)

        })

        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: { (action: UIAlertAction) -> () in

            alertController.dismiss(animated: true, completion: nil)
        })



        alertController.addAction(comfirmAlertAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)


    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showcaseManager.delegate = self

        uploadPokemon.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        uploadPokemon.setTitleColor(UIColor.white, for: .normal)

        cancelPokemon.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        cancelPokemon.setTitleColor(UIColor.white, for: .normal)


        savePokemon.layer.borderWidth = 1.5
        savePokemon.layer.borderColor = UIColor.blue.cgColor
        savePokemon.layer.cornerRadius = 10

        savePokemon.layer.shadowColor = UIColor.black.cgColor
        savePokemon.layer.shadowRadius = 2
        savePokemon.layer.shadowOffset = CGSize(width: 0, height: 2)
        savePokemon.layer.shadowOpacity = 0.8

        


        backShowcase.layer.borderWidth = 1.5
        backShowcase.layer.borderColor = UIColor.blue.cgColor
        backShowcase.layer.cornerRadius = 10

        backShowcase.layer.shadowColor = UIColor.black.cgColor
        backShowcase.layer.shadowRadius = 2
        backShowcase.layer.shadowOffset = CGSize(width: 0, height: 2)
        backShowcase.layer.shadowOpacity = 0.8

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

    }

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
        cell.pokemonImage.contentMode = .scaleAspectFill
        cell.pokemonImage.clipsToBounds = true

        //增加一個cell的target,此target為當deletePokemonAct被按時的方法
        //設定button的標籤數字為當前indexPath.row
        cell.deletePokemon.tag = indexPath.row

        cell.deletePokemon.addTarget(self, action: #selector(deletePokemonAct(_:)), for: .touchUpInside)

        cell.deletePokemon.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        cell.deletePokemon.setTitleColor(UIColor.white, for: .normal)

        return cell
    }






}

