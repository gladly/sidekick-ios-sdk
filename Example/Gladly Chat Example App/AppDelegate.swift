//
//  AppDelegate.swift
//  Gladly Chat Example App
//
//  Copyright © 2019 Gladly. All rights reserved.
//

import UIKit
import UserNotifications
import GladlySidekick

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, GladlyNotificationDelegate {

    /*
     Application ID given to identify your account in Gladly
     */
    let appId = "some-app-id"
    
    /*
     Specify what environment to connect to, either "STAGING" or "PROD"
     */
    let environment = "STAGING"

    var window: UIWindow?

    /*
     Tells the UIApplicationDelegate that the launch process is almost done and the app is almost ready to run.
    */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        var settings = GladlySettings(appId: appId)
        settings.environment = environment
        settings.uiConfiguration.header.text = "Gladly Chat"

        /*
         Initialize Gladly
         */
        do {
            try Gladly.initialize(settings: settings)
            Gladly.notificationDelegate = self
            registerForPushNotifications()
        } catch {
            print("Something went wrong when initializing Gladly: \(error)")
        }

        /*
         Register as the UNUserNotificationCenterDelegate so receive push notifications in this class.
         */
        UNUserNotificationCenter.current().delegate = self

        return true
    }
    
    func registerForPushNotifications() {
        
        // Request authorization from user to send push notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
            
            // Check if permission granted
            guard granted else {
                return
            }
            
            // Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        do {
            /*
             UIApplicationDelegate will receive the deviceToken and should forward it to Gladly
             so that Gladly can send push notifications.
            */
            try Gladly.register(deviceToken: deviceToken)
        } catch {
            print("something went wrong when registering device token: \(error)")
        }
    }
    
    // MARK: GladlyNotificationDelegate implementation
    
    /*
     Called when new message arrives while app in the foreground and chat is not shown.
     */
    func notification(didReceiveNewMessageEvent messageEvent: GladlyMessageEvent) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "New Message", message: messageEvent.body, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            let viewController = UIApplication.shared.keyWindow?.rootViewController
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: UNUserNotificationCenterDelegate implementation
    
    /*
     This function is called when the device is receiving a notification while app is in the background
     AND user clicks on the notification
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if Gladly.handleNotification(didReceive: response) {
            // If the notification was for Gladly, true will be returned
            return
        }
        
        // If the notification was not for Gladly it can be processed here.
        // ...
        
        completionHandler()
    }
    
    /*
     This function is called when the device is receiving a notification while app is running in the foreground
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if Gladly.handleNotification(willPresent: notification.request)  {
            // If the notification was for Gladly, true will be returned
            return
        }
        
        // If the notification was not for Gladly it can be processed here.
        // ...
        
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
    }
}
