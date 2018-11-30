//
//  MainNavigationController.swift
//  FreshList
//
//  Copyright © 2018 Abhi Kumar. All rights reserved.
//
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            // Assumed user is logged in
            let homeScreen = CustomTabBarController()
            viewControllers = [homeScreen]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.0)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return false
    }
    
    @objc func showLoginController() {
        let loginController = LoginController()
        self.present(loginController, animated: true, completion: {
            // Something here later
            })
    }
}
