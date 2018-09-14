//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Iyin Raphael on 8/8/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
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
    
    func scheduleDailyReminderNotification(){
        let content = UNMutableNotificationContent()
        content.title = "TIme to Capture the Moment"
        content.body = "Yo, Create a Memory!"
        
        var date = DateComponents()
        date.hour = 20
        date.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "memory making", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.delegate = self
        
        center.add(request) { (error) in
            if let error = error {
                NSLog("There was a problem trying to schedule notifiaction: \(error)")
                return
            }
        }
        
    }
}
