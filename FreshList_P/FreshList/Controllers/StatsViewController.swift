//
//  StatsViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar(title: "Statistics")
        
    }
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    private func setupNavigationBar(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        // Call function to add buttons to navigation bar
        setupNavigationBarItems()
    }
    
    // Function called to set up buttons in navigation bar
    private func setupNavigationBarItems() {
        configureUserButton()
    }
    
    // Function to set up user button in navigation bar
    private func configureUserButton() {
        
        // Configuration for user info button
        let userImg = UIImage(named: "usercircleicon")
        let userInfoButton = UIButton(type: .system)
        userInfoButton.setImage(userImg, for: .normal)
        userInfoButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        userInfoButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        userInfoButton.tintColor = UIColor.white
        userInfoButton.addTarget(self, action: #selector(handleUserMenu), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userInfoButton)
    }
    
    let userInfoLauncher = UserInfoLauncher()
    
    // Function to show user menu
    @objc private func handleUserMenu() {
        userInfoLauncher.showUserMenu()
    }
    
}
