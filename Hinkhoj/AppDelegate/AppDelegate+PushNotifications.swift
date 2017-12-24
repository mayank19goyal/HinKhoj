//
//  AppDelegate+PushNotifications.swift
//  Medicare
//
//  Created by Mayank Goyal on 16/09/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

enum NotificationType: String {
    case first = "1"
}

extension AppDelegate {
    
    func registerForPushNotifications(_ application: UIApplication) {
        // Parse Configuration
        /*let parseConfiguration = ParseClientConfiguration { (ParseMutableClientConfiguration) in
         ParseMutableClientConfiguration.applicationId = "a989f547-c2c1-4a6c-bbe9-ec891c402e72"
         ParseMutableClientConfiguration.clientKey = "hshZAbOVzV3Or3U2JSWYMXvMklXlLz4B"
         ParseMutableClientConfiguration.server = "https://parse.buddy.com/parse"
         }
         Parse.initialize(with: parseConfiguration)*/
        
        FirebaseApp.configure()
        
        // Notification
        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {
                (success: Bool, _) in
                if success {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            })
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        deviceToken.withUnsafeBytes {
            (tokenChars: UnsafePointer<CChar>) -> Void in
            self.tokenString = String()
            for i in 0..<deviceToken.count {
                tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
            }
            
            _ = (deviceToken as NSData).description
            // provide this device token to client
            let defaults = UserDefaults.standard
            defaults.set(tokenString, forKey: "DeviceToken")
            defaults.synchronize()
            
            print("Device Token: %@", tokenString)
            Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
        }
        
        // Parse
        /*let installation = PFInstallation.current()
         installation?.setDeviceTokenFrom(deviceToken)
         installation?.saveInBackground()
         
         PFPush.subscribeToChannel(inBackground: "") { succeeded, error in
         if succeeded {
         print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n")
         } else {
         print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error!)
         }
         }*/
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if error._code == 3010 {
            HinkhojLogs("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            HinkhojLogs("application:didFailToRegisterForRemoteNotificationsWithError:\n")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        HinkhojLogs("\n \n APNS - Received Remote Notification *************************** \n\n")
        if let info = userInfo as? [String: AnyObject] {
            HinkhojLogs("\n APNS info - *************************** \n \(info) \n ***************************\n")
            guard let alertType = info["notificationType"] as? String else {
                return
            }
            guard let notification = NotificationType(rawValue: alertType) else {
                return
            }
            
            guard let dictAps = info["aps"] as? [String:AnyObject] else {
                return
            }
            
            switch(notification) {
            default:
                break
            }
            
            // Parse
            /*PFPush.handle(userInfo)
             if application.applicationState == UIApplicationState.inactive {
             PFAnalytics.trackAppOpened(withRemoteNotificationPayload: userInfo)
             }*/
        }
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    
    // This method will be called when app received push notifications in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print full message.
        print(userInfo)
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        //Handle the notification
        let userInfo = notification.request.content.userInfo
        // Print full message.
        print(userInfo)
        completionHandler(
            [UNNotificationPresentationOptions.alert,
             UNNotificationPresentationOptions.sound,
             UNNotificationPresentationOptions.badge])
    }
}
