//
//  RecipesViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Recipes")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // Function called to set up navigation bar
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
        configureAddItemButton()
        
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
    
    // Function to set up add item button in navigation bar
    private func configureAddItemButton() {
       
        // Configuration for add recipe button
        let addItemButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(showAddItemView))
        addItemButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = addItemButton
    }
    
    let userInfoLauncher = UserInfoLauncher()
    
    // Function to show user menu
    @objc private func handleUserMenu() {
        userInfoLauncher.showUserMenu()
    }
    
    // Function called by addItemButton to show AddItemView
    @objc private func showAddItemView() {
        let addIngredientController = AddToRecipesViewController()
        navigationController?.pushViewController(addIngredientController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    // BEGIN Table View configurations
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.text = "header"
        label.backgroundColor = UIColor(r: 168, g: 211, b: 143)
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "TEST"
        
        return cell
    }
    // END Table View configurations
    
}
