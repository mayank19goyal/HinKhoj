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
        FirebaseApp.configure()

        // Notification
        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {
                (success: Bool, _) in
                if success {
                    center.delegate = self
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            })
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
        }
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = false
        listenForDirectChannelStateChanges();
        NotificationsController.configure()
    }
    
    func listenForDirectChannelStateChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(onMessagingDirectChannelStateChanged(_:)), name: .MessagingConnectionStateChanged, object: nil)
    }
    
    @objc func onMessagingDirectChannelStateChanged(_ notification: Notification) {
        print("FCM Direct Channel Established: \(Messaging.messaging().isDirectChannelEstablished)")
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
            Messaging.messaging().apnsToken = deviceToken
            #if RELEASE_VERSION
            Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.prod)
            #else
            Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
            #endif
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if error._code == 3010 {
            HinkhojLogs("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            HinkhojLogs("application:didFailToRegisterForRemoteNotificationsWithError:\n")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        HinkhojLogs("\n \n APNS - Received Remote Notification *************************** \n\n")
        if let info = userInfo as? [String: AnyObject] {
            HinkhojLogs("\n APNS info - *************************** \n \(info) \n ***************************\n")
        }
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
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
            
            guard let dictAps = info["word_data"] as? [String:AnyObject] else {
                return
            }
            
            switch(notification) {
            default:
                break
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
        if let userInfo = remoteMessage.appData as? [AnyHashable: Any] {
            if let info = userInfo as? [String: AnyObject] {
                if let dictMessage = info["message"] as? [String: AnyObject] {
                    HinkhojLogs("\n APNS info - *************************** \n \(dictMessage) \n ***************************\n")
                }
            }
        }
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

extension Dictionary {
    /// Utility method for printing Dictionaries as pretty-printed JSON.
    var jsonString: String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
            let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return nil
    }
}
