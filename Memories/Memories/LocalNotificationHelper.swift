//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Nikita Thomas on 10/16/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

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
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification() {
        // Build the content
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"
        content.body = "Don't forget to create a memory for today!"
        
        // Set the timing to trigger
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Build request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        //Schedule Notification
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                NSLog("Error scheduling notification: \(error)")
                return
            }
            NSLog("Notification scheduled for 8pm")
        }
    }
    
}
