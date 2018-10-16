import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    func scheduleDailyReminderNotification() {
        let identifier = "DailyMemoryReminderNotification"
        
        let content = UNMutableNotificationContent()
        content.title = "Daily memory reminder"
        content.body = "The day is almost up! Don't forget to add a new memory for today"
        content.badge = 1
        
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: today)
        
        var dateComponents = DateComponents()
        dateComponents.day = components.day
        dateComponents.month = components.month
        dateComponents.year = components.year
        dateComponents.hour = 20
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                NSLog("Error triggering notification: \(error)")
            }
        }
    }
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
}
