//
//  ShoppingListViewController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

// TODO: Add protocol/delegate functionality for firebase auth
// TODO: Add protocol/delegate functionality for adding item to ingredients list
// TODO: Add functionalities to add/retreive items from DB
// TODO: Add scrollable view.
// TODO: Add functionality to sort items into their categories.
// TODO: Add functionality to be able to check off items, then add those items to ingredients list
// TODO: Add 

import UIKit

class ShoppingListViewController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    let unfiltereditems = ["Potato","Tomatoes","Kiwi","Apples","Apricots","Peas"].sorted()
    var filtereditems: [String]?
    let cellID = "cellID"
    var shoppinglist = [ShoppingList]()

    override func viewDidLoad() {
        filtereditems = unfiltereditems
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        searchController.searchBar.placeholder = "Search for an item,"
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        super.viewDidLoad()
        
        setupNavigationBar(title: "Shopping List")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 80
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        searchController.searchBar.text = ""
        searchController.dismiss(animated: false, completion: nil)
        self.searchController.searchBar.showsCancelButton = false
        searchController.isActive = false
    }
    
    func configureCell(shoppinglist: ShoppingList){
        
    }
    
    private func setupNavigationBar(title: String) {
        // Configure title
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)

        setupNavigationBarItems()
    }
    
    // Function called to set up items in Navigation Bar
    private func setupNavigationBarItems() {
        // TODO: Add search bar and appropriate functionalities. Want to be able to add items quickly searched from our DB
        let addItemButton = setupAddItemButton()
        let barcodeButton = setupBarcodeButton()
        //let searchButton = setupSearchButton()
        navigationItem.rightBarButtonItems = [addItemButton, barcodeButton]
        //navigationItem.leftBarButtonItem = searchButton
    }
    
    // Function to set up add item button in navigation bar
    private func setupAddItemButton() -> UIBarButtonItem {
        let addItemButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(handleAddItem))
        addItemButton.tintColor = UIColor.white
        return addItemButton
    }
    
    // Function called by addItemButton to show AddItemView
    @objc private func handleAddItem() {
        let addShoppingItemController = AddToShoppingListViewController()
        navigationController?.pushViewController(addShoppingItemController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    // Function to set up barcode button in navigation bar
    private func setupBarcodeButton() -> UIBarButtonItem {
        let barcodeImage = UIImage(named: "barcode")
        let barcodeButton = UIBarButtonItem(image: barcodeImage, style: .plain, target: self, action: #selector(handleBarcode))
        barcodeButton.tintColor = UIColor.white
        return barcodeButton
    }
    
    // Function called to open barcode scanner
    @objc private func handleBarcode() {
        let barcodeController = BarcodeScannerViewController()
        navigationController?.pushViewController(barcodeController, animated: true)
//        self.present(barcodeController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    func updateSearchResults(for searchController: UISearchController){
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filtereditems = unfiltereditems.filter { food in
                return food.lowercased().contains(searchText.lowercased())
            }
            
        } else{
            filtereditems = unfiltereditems
        }
        tableView.reloadData()
    }
    // Function to set up search button in navigation bar
//    private func setupSearchButton() -> UIBarButtonItem {
//        let searchBtn = UIButton(type: .custom)
//        var searchImg = UIImage(named: "search")
//        searchImg = searchImg?.maskWithColor(color: UIColor.white)
//        searchBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        searchBtn.setImage(searchImg, for: .normal)
//        searchBtn.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
//        let searchBarItem = UIBarButtonItem(customView: searchBtn)
//        let currWidth = searchBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
//        currWidth?.isActive = true
//        let currHeight = searchBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
//        currHeight?.isActive = true
//        return searchBarItem
//    }
//
    // Function called to search shopping list
    @objc private func handleSearch() {
//
    }
    
    
    
    
    // BEGIN Table View Configurations
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.text = "To Buy"
        label.backgroundColor = UIColor(r: 168, g: 211, b: 143)
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let fooditems = shoppinglist else {
//            return 0
//        }
        return shoppinglist.count
        //return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        //cell.configureCell(shoppinglist: ShoppingList[indexPath.row])
        if let fooditems = filtereditems{
            let food = fooditems[indexPath.row]
            cell.textLabel!.text = food
        }
        //cell.textLabel?.text = "TEST"
        
        return cell
    }
    // END Table View Configurations
 
   
}

