//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Dillon McElhinney on 9/5/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    //Instantiate a notification helper to handle notification permissions and scheduling.
    let localNotificationHelper = LocalNotificationHelper()

    @IBOutlet weak var explanationLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If authorization for notifications has been granted, bypass the onboarding screen. Otherwise, update the explanation label.
        startUp()
    }
    
    // MARK: - UI Methods
    @IBAction func getStarted(_ sender: Any) {
        // Check authorization status
        localNotificationHelper.getAuthorizationStatus { (status) in
            // If the status is not determined, request authorization.
            if status == .notDetermined {
                self.localNotificationHelper.requestAuthorization { (success) in
                    if success {
                        // If it is successful, schedule a notification and move us on from the onboarding screen.
                        self.localNotificationHelper.scheduleDailyReminderNotification()
                        self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
                    } else {
                        // If it is not successful, update the explanation label.
                        self.explanationLabel.text = self.secondExplanation
                    }
                }
            // If the status is determined and we're still on the screen, it means that we aren't authorized.
            } else {
                //Have the button open a url that takes us to our app's settings.
                let url = URL(string: "app-settings:")
                if let url = url {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func startUp() {
        localNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized {
                self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
            } else if status == .denied {
                self.explanationLabel.text = self.secondExplanation
            }
        }
    }

    //Property that just holds the copy for the second explanation.
    let secondExplanation = "It looks like you have previously denied access to notifications. Memories won't work if it doesn't have this access, so you'll be stuck at this screen unless you allow notifications in Settings. Click the button below to go there!"
}
