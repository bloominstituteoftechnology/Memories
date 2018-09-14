//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Welinkton on 9/13/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    // Getting Authorization
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func scheduleDailyReminderNotification() {
        getAuthorizationStatus { (status) in
            if status == .authorized {
            let identifier = "MemoryNotification"
        
        
        // Configuring the Notification contents
        let content = UNMutableNotificationContent()
        content.title = "Create a Memory Today"
        content.body = "What would you like to Remember?"
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 20   // 20:00 hours everyday
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)

        // Create the request
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
                NSLog("There seems to be an error: \(error)")
            }
        }
    }
  }
}
    
  
    
    // Requesting Authorization
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    // Remove Pending Notification Requests
    func removePendingNotificationRequests(withIdentifiers identifiers: [String]){
}
}
