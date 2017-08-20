//
//  URLPhotoManager.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/8/8.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import Foundation
import UIKit

protocol URLImageDelegate: class {

    func manager(_ controller: URLImageManager, imageIndexPath: IndexPath)
}

class URLImageManager {

    weak var delegate: URLImageDelegate?

    func getURLImage(imageURL: String, indexPath: IndexPath) {

 print("🥊🥊🥊🥊🥊🥊🥊🥊🥊")
        print(imageURL)
 print("🥊🥊🥊🥊🥊🥊🥊🥊🥊")

        if imageURL == "" {

               getURLImageDic.updateValue(#imageLiteral(resourceName: "if_pokemon_go_play_game_charcter_5_1392688"), forKey: imageURL)

        } else {


        //將照片網址解開，存入圖片放在imageView上

            if let imageUrl = URL(string: imageURL) {

                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, _, error) in
 print("🥊🥊🥊")
                    if error != nil {

                        print("Download Image Task Fail: \(error!.localizedDescription)")
 print("🥊🥊")
                    } else if let imageData = data {
                        DispatchQueue.main.async {

                            getURLImageDic.updateValue(UIImage(data: imageData as Data)!, forKey: imageURL)
 print("🥊🥊🥊🥊🥊")
                            self.delegate?.manager(self, imageIndexPath: indexPath)
                        }
                        
                    }
                    
                }).resume()
                
            }
        }




//        DispatchQueue.global().async {
//
//            let urlUserPicture = URL(string: imageURL)
//            print("🥊🥊")
//
//
//            let data = NSData(contentsOf: urlUserPicture!)
//
//            DispatchQueue.main.async {
//
//                if let imageData = data {
//
//                    getURLImageDic.updateValue(UIImage(data: imageData as Data)!, forKey: imageURL)
//                    self.delegate?.manager(self, imageIndexPath: indexPath)
//
//                }
//            }
//        }



    }

}
