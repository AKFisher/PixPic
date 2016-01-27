//
//  ImageViewController.swift
//  P-effect
//
//  Created by Illya on 1/26/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var model: ImageViewModel!

    @IBOutlet private weak var rawImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ImageViewController: PhotoEditorDelegate {
    
    func didChooseEffect(effect: UIImage) {
        print("show choosed effect")
    }
    
    func imageWithEffect() -> UIImage {
        print("apply choosed effect on image")
        return UIImage(named: "edit_50")!
    }

}