//
//  ShoppingListViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class ShoppingListViewController: UITableViewController {
    
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Shopping List")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func setupNavigationBar(title: String) {
        // Configure title
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        // Call function to set up buttons
        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
        // TODO: Add search bar and appropriate functionalities. Want to be able to add items quickly searched from our DB
        // TODO: Add button to open up camera and call barcode API. Yea this is a big feature
    }
    
    // BEGIN Table View Configurations
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
    // END Table View Configurations
    
}
