//
//  IngredientsViewController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

// TODO: Add protocol/delegate functionality for firebase auth.
// TODO: Add Firebase DB access functionalities.
// TODO: Add functionalities to add/retrieve items from DB.
// TODO: Add scrollable view.
// TODO: Add functionality to sort items into their categories.

import UIKit
import Firebase

class IngredientsViewController: UITableViewController {

    let cellID = "cellID"
    var boughtItems: [IngredientList] = []
    var ingredientListCollectionRef: CollectionReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Pantry")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 80
        ingredientListCollectionRef = Firestore.firestore().collection(kIngredients)
    }

    override func viewWillAppear(_ animated: Bool) {
        ingredientListCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let ingredientname = data["Ingredient_name"] as? String ?? "Anonymous"
                    let quantity = data["Quantity"] as? Float ?? 0
                    let category = data["Category"] as? String ?? ""
                    let expirydate = data["Expiry_date"] as? Date ?? Date()
                    let ownerId = data["ownerId"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    
                    let newIngredientList  = IngredientList(_ingredientname: ingredientname, _quantity: quantity, _category: category, _expirydate: expirydate, _id: id)
                    self.boughtItems.append(newIngredientList)
                }
                self.tableView.reloadData()
            }
        }
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
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = searchButton
        
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
   // override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {//
//        let label = UILabel()
//        label.text = "header"
//        label.backgroundColor = UIColor(r: 168, g: 211, b: 143)
//        return label
//    }
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boughtItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let fooditems = boughtItems[indexPath.row]
        cell.textLabel?.text = fooditems.ingredientname

        return cell
    }
    // END Table View configurations
}
