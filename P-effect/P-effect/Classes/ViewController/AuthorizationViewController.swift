//
//  AuthorizationViewController.swift
//  P-effect
//
//  Created by anna on 1/16/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func logInWithFBButtonTapped() {
        view.makeToastActivity(CSToastPositionCenter)
        FBAuthorization.signInWithFacebookInController(
            self, completion: {
                [weak self] user, error in
                if let user = user as User! {
                    UserModel.init(aUser: user).checkIfFacebookIdExists(
                        { exists in
                            if exists {
                                user.passwordSet = false
                                FBAuthorization.signInWithPermission(
                                    { user, error in
                                        if let error = error {
                                            print(error)
                                        } else if let user = user {
                                            print("SIGNING INN!!!  with ",  user.username)
                                            Router.sharedRouter().showHome(animated: true)
                                        } else {
                                            print("unknown trouble while signing IN")
                                        }
                                        self?.view.hideToastActivity()
                                    }
                                )
                                
                            } else {
                                
                                PFFacebookUtils.logInInBackgroundWithAccessToken(
                                    FBSDKAccessToken.currentAccessToken(),
                                    block: {
                                        user, error in
                                        PFFacebookUtils.logInInBackgroundWithAccessToken(FBSDKAccessToken.currentAccessToken())
                                        let user = UserModel.init(aUser: User.currentUser()!)
                                        user.linkOrUnlinkFacebook(
                                            { success, error in
                                                if let error = error {
                                                    print(error)
                                                } else {
                                                    print("LINKED!!! NEED TO UPDATE DATA")
                                                    AuthService.updatePFUserDataFromFB(
                                                        user.user,
                                                        completion: {
                                                            user, error in
                                                            if let error = error {
                                                                print(error)
                                                            } else if let _ = user {
                                                                print("User has been updated")
                                                            }
                                                        }
                                                    )
                                                }
                                            }
                                        )
                                        self?.view.hideToastActivity()
                                        Router.sharedRouter().showHome(animated: true)
                                    }
                                )
                            }
                        }
                    )
                }
                print("connectWithFacebookAction called")
            }
        )
    }
    
}