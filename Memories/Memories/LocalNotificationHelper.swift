//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Daniela Parra on 9/5/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
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
    
    func scheduleDailyReminderNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Make a memory"
        content.body = "Don't forget to add a memory from today's adventure called \"Life\"."
        
        var date = DateComponents()
        date.hour = 20
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
    
        let request = UNNotificationRequest(identifier: "DailyReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                NSLog("Error adding notification: \(error)")
            }
        }
    }
    
}
