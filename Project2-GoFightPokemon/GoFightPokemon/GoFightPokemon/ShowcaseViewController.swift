//
//  ShowcaseViewController.swift
//  GoFightPokemon
//
//  Created by Wei-Tsung Cheng on 2017/7/31.
//  Copyright © 2017年 Wei-Tsung Cheng. All rights reserved.
//

import UIKit

class ShowcaseViewController: UIViewController {



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ShowcaseViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBAction func showPokemon(_ sender: Any) {

        let photoImagePickerController = UIImagePickerController()

        photoImagePickerController.delegate = self
        

        photoImagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary


        photoImagePickerController.allowsEditing = true


        self.present(photoImagePickerController, animated: true, completion: nil)
        
    }
}
