//
//  PhotoEditorModel.swift
//  P-effect
//
//  Created by Illya on 1/26/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class PhotoEditorModel: NSObject {
    
    private let setOriginalImage: UIImage
    
    init(image: UIImage) {
        setOriginalImage = image
        
        super.init()
    }
    
    func originalImage() -> UIImage {
        return setOriginalImage
    }
}
