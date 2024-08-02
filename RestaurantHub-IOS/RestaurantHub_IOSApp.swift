//
//  RestaurantHub_IOSApp.swift
//  RestaurantHub-IOS
//
//  Created by Sushant Dhakal on 2024-07-08.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                  if let error = error {
                      print("Error requesting notification authorization: \(error)")
                  } else {
                      print("Notification authorization granted: \(granted)")
                  }
              }
              UNUserNotificationCenter.current().delegate = self

    return true
  }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound, .badge])
        }
}

@main
struct RestaurantHub_IOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RestaurantListView()
        }
    }
}
