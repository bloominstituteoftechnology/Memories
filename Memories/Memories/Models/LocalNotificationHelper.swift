//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Scott Bennett on 9/12/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation
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
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    // Schedule a daily reminder
    func scheduleDailyReminderNotification() {
        // Unique identifier for the notification
        let identifier = "DailyReminder"
        
        // What is displayed on the notification
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.subtitle = ""
        content.body = "It is time to make a memory!"
        content.badge = 1
        
        // When the notification gets shown to the user
        var date = DateComponents()
        date.hour = 20
        date.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        //The notification
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                NSLog("Error adding notification \(error)")
            }
        }
        
        
        
        
    }
}
