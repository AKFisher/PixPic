//
//  NSError+ErrorType.swift
//  P-effect
//
//  Created by Jack Lapin on 17.02.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

extension NSError {
    
    static func createAuthError(type: AuthError) -> NSError? {
        switch type {
        case .FacebookError:
            let error = NSError(
                domain: NSBundle.mainBundle().bundleIdentifier!,
                code: 701,
                userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Facebook error", comment: "")]
            )
            return error
            
        default:
            return nil
        }
    }
    
}
