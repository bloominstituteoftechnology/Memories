//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Conner on 8/1/18.
//  Copyright © 2018 Conner. All rights reserved.
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
        content.title = "Create a memory for today!"
        content.sound = UNNotificationSound.default

        var date = DateComponents()
        date.hour = 21
        date.minute = 29
        print("Date set: \(date)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

        let request = UNNotificationRequest(identifier: "MemoryReminder", content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("There was an error with daily memory reminder notification: \(error)")
            }
        }
    }
}


