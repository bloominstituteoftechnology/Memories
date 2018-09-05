//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Moin Uddin on 9/5/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        localnotificationHelper.getAuthorizationStatus { (status) in
            switch status {
            case .authorized:
                self.performSegue(withIdentifier: "Memories", sender: nil)
            default:
                return
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStarted(_ sender: Any) {
        localnotificationHelper.requestAuthorization { (granted) in
            if granted {
                self.localnotificationHelper.scheduleDailyReminderNotification()
                self.performSegue(withIdentifier: "Memories", sender: nil)
            } else {
                return
            }
        }
    }
    
    let localnotificationHelper = LocalNotificationHelper()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
