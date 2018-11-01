//
//  IngredientsViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/19/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit


class IngredientsViewController: UITableViewController {

    // IDK tf this is for but you need it for the table view to show up properly apparently
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Ingredients")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    
    // Function called to set up Navigation Bar
    private func setupNavigationBar(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        // Call function to set up buttons
        setupNavigationBarItems()
    }
    
    // Function called to set up items in Navigation Bar
    private func setupNavigationBarItems() {
        let addButton = setupAddItemButton()
        let searchButton = setupSearchButton()
        navigationItem.rightBarButtonItems = [addButton, searchButton]
        
    }
    
    // Function to set up add item button in navigation bar
    private func setupAddItemButton() -> UIBarButtonItem {
        // Configuration for add ingredient button
        let addItemButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(handleAddItem))
        addItemButton.tintColor = UIColor.white
        return addItemButton
    }
    
    // Function called by addItemButton to show AddItemView
    @objc private func handleAddItem() {
        // Configuring UI for addItem
        let addIngredientController = AddToIngredientsViewController()
        navigationController?.pushViewController(addIngredientController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
    }
    
    // Function to set up search button in navigation bar
    private func setupSearchButton() -> UIBarButtonItem {
        let searchBtn = UIButton(type: .custom)
        var searchImg = UIImage(named: "search")
        searchImg = searchImg?.maskWithColor(color: UIColor.white)
        searchBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        searchBtn.setImage(searchImg, for: .normal)
        searchBtn.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        let searchBarItem = UIBarButtonItem(customView: searchBtn)
        let currWidth = searchBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = searchBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        return searchBarItem
    }
    
    // Function called to search shopping list
    @objc private func handleSearch() {
        // TODO: Add search functionality
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
