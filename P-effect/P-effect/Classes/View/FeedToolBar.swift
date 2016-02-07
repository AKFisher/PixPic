//
//  FeedToolBar.swift
//  P-effect
//
//  Created by Jack Lapin on 05.02.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class FeedToolBar: UIView {
    
    var selectionClosure: (() -> Void)?

    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> FeedToolBar? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? FeedToolBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animateToolBar(up: Bool) {
        bottomSpaceConstraint.constant = up ? -Constants.BaseDimensions.ToolBarHeight : 0
        topSpaceConstraint.constant = up ? Constants.BaseDimensions.ToolBarHeight : 0
        layoutIfNeeded()
        bottomSpaceConstraint.constant = up ? 0 : -Constants.BaseDimensions.ToolBarHeight
        topSpaceConstraint.constant = up ? 0 : Constants.BaseDimensions.ToolBarHeight
        UIView.animateWithDuration(
            0.7,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.7,
            options: .CurveEaseInOut,
            animations: {
                self.layoutIfNeeded()
            },
            completion: nil
        )
    }

    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    
    @IBAction func makePhotoButtonTapped() {
        selectionClosure?()
    }
    
}
