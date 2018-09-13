//
//  OnboardingViewController.swift
//  Memories-W2D3
//
//  Created by Ilgar Ilyasov on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    let theLocalNotificationHelper = LocalNotificationHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        theLocalNotificationHelper.getAuthorizationStatus { (status) in
            if status == .authorized {
                self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        theLocalNotificationHelper.requestAuthorization { (success) in
            self.theLocalNotificationHelper.scheduleDailyReminderNotification()
            if success {
                self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OnboardingSegue" {
            guard let destinationVC = segue.destination as? UINavigationController else { return }
            destinationVC.show(destinationVC, sender: nil)

        }
    }
}
