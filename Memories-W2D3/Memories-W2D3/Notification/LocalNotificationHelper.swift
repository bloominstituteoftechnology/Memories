//
//  LocalNotificationHelper.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
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
            
            if let error = error {
                NSLog("Error requesting authorization status for local notifications: \(error)")
            }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification() {
        getAuthorizationStatus { (status) in
            if status == .authorized {
                let identifier = "DailyNotification"
                
                let content = UNMutableNotificationContent()
                content.title = "The localized title, containing the reason for the alert"
                content.subtitle = "The localized subtitle, containing a secondary description of the reason for the alert"
                content.body = "The localized message to display in the notification alert"
                
                var date = DateComponents()
                date.hour = 20
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        NSLog("Daily notification error: \(error)")
                    }
                }
            }
        }
    }
    
//    func presentAlert() {
//
//    }
}
