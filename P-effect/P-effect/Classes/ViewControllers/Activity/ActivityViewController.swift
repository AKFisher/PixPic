//
//  ActivityViewController.swift
//  P-effect
//
//  Created by Jack Lapin on 02.03.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class ActivityViewController: UIActivityViewController {
    
    private let facebookMessage = "Posted on Facebook!"
    private let twitterMessage = "Tweeted!"
    private let cameraRollMessage = "Saved to Photos!"
    private let vkMessage = "Posted to VK!"
    private let applyToContactMessage = "Applied to contact!"
    private let doneMessage = "Shared!"
    
    private let activityTypePostToVK = "com.vk.vkclient.shareextension"
    
    static func initWith(items: [AnyObject]) -> ActivityViewController {
        let activityViewController = ActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToTencentWeibo,
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeOpenInIBooks
        ]
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if let error = error {
                log.debug(error.localizedDescription)
            }
            if let activity = activity where success  {
                let message = activityViewController.activityViewController(
                    activityViewController,
                    itemForActivityType: activity
                    ) as? String
                AlertManager.sharedInstance.showSimpleAlert(message!)
            }
        }
        
        return activityViewController
    }
    
}

// MARK: - UIActivityItemSource methods
extension ActivityViewController: UIActivityItemSource {
    
    func activityViewControllerPlaceholderItem(activityViewController: UIActivityViewController) -> AnyObject {
        return ""
    }
    
    func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        switch activityType {
        case UIActivityTypePostToFacebook:
            return facebookMessage
            
        case UIActivityTypePostToTwitter:
            return twitterMessage
            
        case UIActivityTypeSaveToCameraRoll:
            return cameraRollMessage
            
        case UIActivityTypeAssignToContact:
            return applyToContactMessage
            
        case activityTypePostToVK:
            return vkMessage
            
        default:
            return doneMessage
        }
    }
    
}