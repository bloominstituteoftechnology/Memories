//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Lisa Sampson on 8/8/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper: NSObject, UNUserNotificationCenterDelegate {
    
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
        let content = UNMutableNotificationContent()
        content.title = "Daily Memories Reminder"
        content.body = "Don't forget to create a memory today!"
        
        var date = DateComponents()
        date.hour = 20
        date.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "MemoryNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.delegate = self
        
        center.add(request) { (error) in
            if let error = error {
                print("There was was problem trying to schedule the notification \(error).")
                return
            }
        }
    }
    
}
