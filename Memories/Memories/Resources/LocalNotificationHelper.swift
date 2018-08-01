//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by De MicheliStefano on 01.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    // This is boilerplate code used for virtually every local notification
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
        content.title = "Reminder to capture today\'s memory"
        content.body = "Capture today\'s memory by adding a picture and your memory's description"
        
        var date = DateComponents()
        date.hour = 20
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "DailyMemoryReminder", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("There was an error scheduling a notification: \(error)")
                return
            }
            
        }
        
    }
    
}
