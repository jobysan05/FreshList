//
//  AppDelegate.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import FirebaseCore
import UserNotifications


struct defaultsKeys {
    static let keyOne = "firstStringKey"
    static let flags = "0"
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainNavigationController()
        window?.makeKeyAndVisible()
        
        let defaults = UserDefaults.standard
        
        // Initialize Firebase within app
        FirebaseApp.configure()
        
        // BEGIN Setup of push notifications
        // Check iOS version to determine notification methods
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self as? MessagingDelegate
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        ConnectToFCM()
        Messaging.messaging().isAutoInitEnabled = true
        // END Setup of push notifications

        // Get rid of shadow under navigation bar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        // Change highlight color of tab bar buttons
        let darkGreen: UIColor = UIColor(r: 48,g: 89, b: 23)
        UITabBar.appearance().tintColor = darkGreen
        
        // Change font color in status bar to white and make background darker
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        return true
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        ConnectToFCM()
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    func ConnectToFCM() {
        //        Messaging.messaging().shouldEstablishDirectChannel = true
        //creating the notification content
        let content = UNMutableNotificationContent()
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("FreshList_Ingredients").whereField("ownerId", isEqualTo: user)
            .addSnapshotListener { documentSnapshot, error in
                guard let doc_val = documentSnapshot else {
                    return
                }
                for doc in doc_val.documents {
                    let data = doc.data()
                    let today = Date()
                    let current_date = today.toString(dateFormat: "MM/dd/yyyy")
                    let expiry_date = "\(data["Expiry_date"]!)"
                    let futureDate = Date(timeInterval: 3*86400, since: today)
                    let fd = futureDate.toString(dateFormat: "MM/dd/yyyy")
                    print("\(expiry_date)")

                    print("\(current_date)")
                    print("future date \(fd)")

                    if(current_date.compare(expiry_date) == .orderedSame){
                        print("item expires today")
                        content.title = "\(data["Ingredient_name"]!) is expiring Today!"
                        content.subtitle = ""
                        content.body = ""
                        //                    content.badge = 1
                        //get the notification trigger
                        // Configure the trigger for a scheduled notification.
                        
                        var dateInfo = DateComponents()
                        dateInfo.hour = 9
                        dateInfo.minute = 03
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                        
                        //getting the notification request
                        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().delegate = self
                        
                        
                        //adding the notification to notification center
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        //

                    }
                    else if (current_date.compare(expiry_date) == .orderedAscending) {
                        
                        print("The left operand is lesser than the right operand.")
                        content.title = "\(data["Ingredient_name"]!) has expired!"
                        content.subtitle = ""
                        content.body = ""
                        //                    content.badge = 1
                        //get the notification trigger
                        // Configure the trigger for a scheduled notification.
                        
                        var dateInfo = DateComponents()
                        dateInfo.hour = 9
                        dateInfo.minute = 03
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                        
                        //getting the notification request
                        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().delegate = self
                        
                        
                        //adding the notification to notification center
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        //
                        
                    }
                    else if(fd.compare(expiry_date) == .orderedSame) {
                        
                        content.title = "\(data["Ingredient_name"]!) is expiring in three days!"
                        content.subtitle = ""
                        content.body = ""
                        //                    content.badge = 1
                        //get the notification trigger
                        // Configure the trigger for a scheduled notification.
                        
                        var dateInfo = DateComponents()
                        dateInfo.hour = 9
                        dateInfo.minute = 03
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                        
                        //getting the notification request
                        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().delegate = self
                        
                        
                        //adding the notification to notification center
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        //
                        
                        
                    }
                    else {
                        print("expiry date not close")
                        
                    }
                   
                }
               
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        ConnectToFCM()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FreshList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }

}

