//
//  AppDelegate.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//

import UIKit
import UserNotifications
import Firebase
import Parse
import RealmSwift

let currentUserKey = "currentUser"
typealias CompletionHandler = (_ success: Bool) -> Void

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LyieLog.init(shouldShowLogs: true)
        //        IQKeyboardManager.shared.enable = true
        configureServices()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            self.window?.overrideUserInterfaceStyle = .light
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth
        //        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
        
        // Further handling of the device token if needed by the app
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Fetch no sooner than every (60) seconds which is thrillingly short actually.
        // Defaults to Infinite if not set.
        UIApplication.shared.setMinimumBackgroundFetchInterval(60)
    }
    
    func saveInstallationObject() {
        if let installation = PFInstallation.current() {
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully connected your app to Back4App!")
                } else {
                    if let myError = error {
                        print(myError.localizedDescription)
                    } else {
                        print("Uknown error")
                    }
                }
            }
        }
    }
    
    func startLogoutProcess(completionHandler: CompletionHandler) {
        // 1. Create group
        let taskGroup = DispatchGroup()
        
        // Logout from current user on Firebase
        taskGroup.enter()
        do {
            try PFUser.logOut()
        } catch {
            print("logout")
        }
        taskGroup.leave()
        
        // Delete all notifiers
        taskGroup.enter()
        
        UserNotifier.shared.removeAll()
        StudentInfoNotifier.shared.removeAll()
        StudentEducationNotifier.shared.removeAll()
        QuestionNotifier.shared.removeAll()
        ResearchNotifier.shared.removeAll()
        NewUserNotifier.shared.removeAll()
        HomeMentorNotifier.shared.removeAll()
        EducationMainCourseNotifier.shared.removeAll()
        EducationChildCoursesNotifier.shared.removeAll()
        EducationMainLessonsNotifier.shared.removeAll()
        EducationChildLessonsNotifier.shared.removeAll()
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        taskGroup.leave()
        
        // Delete all realm Objects
        taskGroup.enter()
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Realm Delete Error")
        }
        taskGroup.leave()
        
        
        // Delete all User Defaults Objects
        taskGroup.enter()
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        taskGroup.leave()
        
        // Wait for 4 threads to complete
        taskGroup.wait()
        
        // Finally Look for Realm is deleted and logged out
        if PFUser.current() == nil && realm.isEmpty {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}

extension AppDelegate {
    func configureServices() {
        
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "myappID"
            $0.clientKey = "3HDpH3FgNDnq"
            $0.server = "http://54.237.251.163/parse"
        }
        Parse.initialize(with: configuration)
        
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        
        saveInstallationObject()
//        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        FirebaseApp.configure()
        FirebaseRemoteConfigService.shared.configure()
        StyleManager.configure()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
//        window?.rootViewController = ContainerController()
        
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
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


extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
    }
    
}


extension AppDelegate {
    func prepareInternetConnectivityTopView() {
        
        let topViewController = window?.topViewController()
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? MainNavigationController {
            navigationController.prepareInternetConnectivityTopView()
        } else {
            let myView = Bundle.loadView(fromNib: "InternetConnectivityAlert", withType: InternetConnectivityAlert.self)
            myView.textLabel.text = .localized(.internet_connection)
            myView.frame = CGRect(x: 0, y: 0, width: (topViewController?.view.frame.width)!, height: 40)
            myView.center = CGPoint(x: (topViewController?.view.frame.width)!/2, y: (topViewController?.view.frame.minY)! + 20)
            topViewController?.view.addSubview(myView)
            myView.alpha = 0
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
                myView.alpha = 0.8
            }, completion: {(finished: Bool) in
                UIView.animate(withDuration: 2, delay: 2, options: .curveEaseOut, animations: {
                    myView.alpha = 0
                }, completion: {(finished: Bool) in
                    myView.removeFromSuperview()
                })
            })
        }
    }
}
