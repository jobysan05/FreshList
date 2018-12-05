//
//  MainNavigationController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.isNavigationBarHidden = true
        checkIfLoggedIn()
    }
    
    
    private func checkIfLoggedIn() {
        if isLoggedIn() {
            // Assume user is logged in
            let homeController = CustomTabBarController()
            viewControllers = [homeController]
        } else {
            perform(#selector(showLoginView), with: nil, afterDelay: 0.0)
        }
    }
    
    @objc func showLoginView() {
        let onboardingController = OnboardingController()
        present(onboardingController, animated: true, completion: {
            // Something here later
        })
    }
    
    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.getisLoggedIn()
    }
    
    
}
