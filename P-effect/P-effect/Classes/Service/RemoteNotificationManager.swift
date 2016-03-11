//
//  RemoteNotificationManager.swift
//  P-effect
//
//  Created by AndrewPetrov on 3/3/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation

class RemoteNotificationManager {
    
    static func switchNotificationAvailbilityState(to enabled: Bool) {
        let application = UIApplication.sharedApplication()
        if enabled {
            let settings = UIUserNotificationSettings(
                forTypes: [.Alert, .Badge, .Sound],
                categories: nil
            )
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            application.unregisterForRemoteNotifications()
        }
    }
    
}