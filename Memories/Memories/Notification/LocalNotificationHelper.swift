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
        content.title = "Memory saving Time"
        content.body = "Time to save important memories from photo gallery!"
        
        
        var date = DateComponents()
        date.hour = 8
        date.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "memoryNotification", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.add(request) { (error) in
            if let error = error {
                print("There was a problem trying to schedule notifiaction, its phone's fault \(error)")
                return
            }
        }
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification Arrived")
        completionHandler([.alert, .sound])
        
    }

}
