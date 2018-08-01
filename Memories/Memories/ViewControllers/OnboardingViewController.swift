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
            }
        }
        performSegue(withIdentifier: "ShowMemoriesTableModal", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Properties
    
    var localNotificationHelper = LocalNotificationHelper()
}
