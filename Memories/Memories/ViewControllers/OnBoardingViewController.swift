//
//  ViewController.swift
//  Memories
//
//  Created by Simon Elhoej Steinmejer on 01/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController
{
    var notificationHelper: LocalNotificationHelper?
    
    let welcomeLabel: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        
        let attributedText = NSMutableAttributedString(string: "Welcome to Memories!", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22, weight: .medium), NSAttributedStringKey.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "\n\nWe're going to help you document every day of your life. In order to do this, we need you to allow the application to send you notifications so you can be reminded to create a memory every day! We'll also ask for your permission to access your photo library to attach photos to your memories.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.black]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    let getStartedButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Get Started!", for: .normal)
        button.addTarget(self, action: #selector(handleGetStarted), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        
        
    }

    @objc private func handleGetStarted()
    {
        notificationHelper?.requestAuthorization { (success) in
            if success
            {
                self.notificationHelper?.scheuleDailyReminderNotification()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func setupUI()
    {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, getStartedButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        
        welcomeLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        
        view.addSubview(stackView)
        
        stackView.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 300)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}





















