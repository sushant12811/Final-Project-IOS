import Foundation
import UserNotifications

class NotificationGenerator {
    
    static func generateNotification(title: String, description: String) async {
        await requestAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        content.sound = .default
        // Add the custom icon
        content.launchImageName = "img"
        
        // Set up the trigger to repeat every hour
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // Short interval for testing
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        print("Notification scheduled with UUID: \(uuidString)")
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        do {
            try await notificationCenter.add(request)
        } catch {
            print("Error adding notification request: \(error)")
        }
    }
    
    static func requestAuthorization() async {
        let center = UNUserNotificationCenter.current()
        
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        } catch {
            print("Error requesting notification authorization: \(error)")
        }
    }
}
