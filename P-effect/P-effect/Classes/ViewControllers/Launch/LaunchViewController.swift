//
//  LaunchViewController.swift
//  P-effect
//
//  Created by AndrewPetrov on 3/3/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation

final class LaunchViewController: UIViewController, StoryboardInitable {
    
    static let storyboardName = Constants.Storyboard.LaunchScreen
    
    private var router: GeneralViewControllerRouterProtocols!
    
    // MARK: - Setup methods
    func setRouter(router: GeneralViewControllerRouterProtocols) {
        self.router = router
    }

}
