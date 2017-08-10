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

    var delegate: URLImageDelegate?

    func getURLImage(imageURL: String, indexPath: IndexPath){

        DispatchQueue.global().async {

            let urlUserPicture = URL(string: imageURL)

            let data = NSData(contentsOf: urlUserPicture! as URL)

            DispatchQueue.main.async {

                if let imageData = data{

                    getURLImageDic.updateValue(UIImage(data: imageData as Data)!, forKey: imageURL)
                    self.delegate?.manager(self, imageIndexPath: indexPath)

                }
            }
        }
    }


}


