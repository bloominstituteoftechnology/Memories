//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Carolyn Lea on 8/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper
{
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void)
    {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification()
    {
        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "It's time to create a memory!"
        content.sound = UNNotificationSound.default()
        
//        let date = Date(timeIntervalSinceNow: 60)
//        let triggerDaily = Calendar.current.dateComponents([.hour, .minute], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: true)
        let request = UNNotificationRequest(identifier: "MemoryNotification", content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error
            {
                NSLog("There was an error \(error)")
                return
            }
        }
    }
    
    
    
}
