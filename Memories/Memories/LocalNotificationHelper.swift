import UIKit
import UserNotifications

class LocalNotificationHelper {
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification() {
        let content = UNMutableNotificationContent()
        content.title = "It's the end of the day 📝!"
        content.body = "Would you like to record a memory for today?"
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        date.hour = 20
        date.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        
    }
}
