//
//  StatsViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/25/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // Configure user icon
    let userIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "usercircleicon")?.withRenderingMode(.alwaysTemplate)
        icon.contentMode = .scaleAspectFill
        icon.tintColor = UIColor(r: 128, g: 171, b: 103)
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    // Configure username label
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Configure logout button
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 20
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Function called to logout and go back to login/register view
    @objc func handleLogout() {
        
        let logoutAlert = UIAlertController(title: "Are you sure?", message: "You will be logged out.", preferredStyle: .alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            // TODO: Add Firebase functionality to log out
            let loginController = LoginController()
            self.present(loginController, animated: true, completion: nil)
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        
        present(logoutAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(usernameLabel)
        view.addSubview(userIcon)
        view.addSubview(logoutButton)
        
        setupView()
        setupNavigationBar(title: "FreshList")
        
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        setupUsernameLabel()
        setupUserIcon()
        setupLogoutButton()
    }
    
    private func setupNavigationBar(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        // Call function to add buttons to navigation bar
//        setupNavigationBarItems()
    }
    
    // Function called to set up buttons in navigation bar
//    private func setupNavigationBarItems() {
//    }
    
    // Function to set up bounadaries and constraints for user icon
    private func setupUserIcon() {
        // Set up X, Y, width, and height constraints for user icon
        userIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        userIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        userIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // Function to set up bounadaries and constraints for username label
    private func setupUsernameLabel() {
        // Set up X, Y, width, and height constraints for username label
        usernameLabel.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 8).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor).isActive = true
        
        
    }
    
    // Function to set up boundaries and constraints for logout button
    private func setupLogoutButton() {
        // Set up X, Y, width, and height constraints for logout button
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
