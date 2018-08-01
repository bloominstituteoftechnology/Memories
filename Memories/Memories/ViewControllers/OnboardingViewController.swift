//
//  OnboardingViewController.swift
//  Memories
//
//  Created by De MicheliStefano on 01.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus() { (completion) in
            if completion == .authorized {
                self.performSegue(withIdentifier: "ShowMemoriesTableModal", sender: nil)
            }
        }
    }
    
    // MARK: - Methods
    
    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization() { (completion) in
            if completion {
                self.localNotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "ShowMemoriesTableModal", sender: nil)
            }
        }
    }
    
    // MARK: - Properties
    
    var localNotificationHelper = LocalNotificationHelper()
}
