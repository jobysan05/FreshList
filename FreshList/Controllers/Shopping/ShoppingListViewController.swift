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
import Firebase
import SwipeCellKit

class ShoppingListViewController: UITableViewController, UISearchResultsUpdating  {
    
    let searchController = UISearchController(searchResultsController: nil)
    //let unfiltereditems = ["Potato","Tomatoes","Kiwi","Apples","Apricots","Peas"].sorted()
    var filtereditems: [String]?
    var shoppinglistnames = [String]()
    let cellID = "cellID"
    var shoppinglist = [ShoppingList]()
    var shoppingListCollectionRef: CollectionReference!
    
    var defaultOptions = SwipeTableOptions()
    //var isSwipeRightEnabled = true
    

    override func viewDidLoad() {
        
        shoppingListCollectionRef = Firestore.firestore().collection(kSHOPPINGLIST)
        
        filtereditems = shoppinglistnames
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        searchController.searchBar.placeholder = "Search for an item"
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        super.viewDidLoad()
        
        setupNavigationBar(title: "Shopping List")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 80
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    override func viewWillAppear(_ animated: Bool) {
        pullfromDBAndUpdate()
    }
    
    func pullfromDBAndUpdate() {
        print("I have been called pull and update")
        shoppingListCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let name = data["ingredient_Name"] as? String ?? "Anonymous"
                    let units = data["units"] as? String ?? ""
                    let amount = data["amount"] as? Float ?? 0
                    let ownerId = data["ownerId"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    
                    let newShoppinglistItem  = ShoppingList(_name: name, _amount: amount, _units: units, _id: id)
                    self.shoppinglist.append(newShoppinglistItem)
                    
                    self.shoppinglistnames.append(name)
//                    print(self.shoppinglistnames)
                }
                self.tableView.reloadData()
            }
        }
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
            filtereditems = shoppinglistnames.filter { name in
                return name.lowercased().contains(searchText.lowercased())
            
            }

        } else{
            filtereditems = shoppinglistnames
        }
        tableView.reloadData()
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let fooditems = filtereditems else {
            return 0
       }
        return fooditems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        //cell.delegate = self
//        cell.selectedBackgroundView = createSelectedBackgroundView()
//
//        let fooditems = shoppinglist[indexPath.row]
//        cell.textLabel?.text = fooditems.name
        //cell.configureCell(shoppinglist: ShoppingList[indexPath.row])
          if let fooditems = filtereditems {
            let food = fooditems[indexPath.row]
            cell.textLabel!.text = food
        }
        //cell.textLabel?.text = "TEST"
        
        return cell
    }
    // END Table View Configurations
 
    // SwipeTableViewCell delegate functions
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//
//        var item: ShoppingList!
//        item = shoppinglist[indexPath.row]
//
//        if orientation == .left {
//            guard isSwipeRightEnabled else { return nil}
//
//            let buyitem = SwipeAction(style: .default, title: nil, handler: {action, indexPath in
////                item.isBought = !item.isBought
////                item.up
//            let user = Auth.auth().currentUser?.uid
//
//            //let db = Firestore.firestore()
//            var ref: DocumentReference? = nil
//            db.collection("FreshList_Ingredients").document(user!).collection("ITEMS").document().setData ([
//                "Ingredient_name": item.name,
//                "Quantity": item.amount,
//                "Category": "Unknown",
//                "Expiry_date": "",
//                "ownerId": Auth.auth().currentUser?.uid,
//                ]) { err in
//                    if let err = err {
//                        print("Error adding document: \(err)")
//                    } else {
//                        print("Document added with ID: \(ref!.documentID)")
//                    }
//                }
//
//            self.shoppinglist.remove(at: indexPath.row)
//            tableView.reloadData()
//            })
//            buyitem.accessibilityLabel = item.isBought ? "Bought" : "Return"
//            let descriptor: ActionDescriptor = item.isBought ? .returnitem : .bought
//            configure(action: buyitem, with: descriptor)
//            return[buyitem]
//        } else {
//            let delete = SwipeAction(style: .destructive, title: nil, handler: { (action, indexPath) in
//                self.shoppinglist.remove(at: indexPath.row)
//                self.tableView.beginUpdates()
//                action.fulfill(with: .delete)
//                self.tableView.endUpdates()
//            })
//            configure(action: delete, with: .trash)
//            return[delete]
//        }
//    }
//
//    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
//        action.title = descriptor.title()
//        action.image = descriptor.image()
//        action.backgroundColor = descriptor.color
//    }
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//
//        var options = SwipeTableOptions()
//        options.expansionStyle = orientation == .left ? .selection : .destructive
//        options.transitionStyle = defaultOptions.transitionStyle
//        options.buttonSpacing = 11
//
//        return options
//    }
    
}
