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
import Foundation
import Firebase
import SwipeCellKit
import KRProgressHUD

class ShoppingListViewController: UITableViewController, UISearchResultsUpdating, SwipeTableViewCellDelegate  {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredItemsNames: [String]?
    var shoppinglistnames = [String]()
    let cellID = "cellID"
    var shoppinglist = [ShoppingListItem]()
    var shoppingListCollectionRef: CollectionReference!
    var shoppingListener: ListenerRegistration!
    
    var defaultOptions = SwipeTableOptions()
    var isSwipeRightEnabled = true
    

    override func viewDidLoad() {
        
        shoppingListCollectionRef = Firestore.firestore().collection(kSHOPPINGLIST)
        
        filteredItemsNames = shoppinglistnames
        print(filteredItemsNames!.count)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        searchController.searchBar.placeholder = "Search for an item"
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
        
        super.viewDidLoad()
        setupNavigationBar(title: "Shopping List")
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        pullfromDBAndUpdate()
    }
    
    func pullfromDBAndUpdate() {
        //print("I have been called pull and update")
        shoppingListener = shoppingListCollectionRef
            .order(by: kNAME, descending: false)
            .addSnapshotListener { (snapshot, error) in // looks dynamically for changes made to the app and refreshethe app
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                self.shoppinglist.removeAll()                                   // changes wont just add to the app but replace it
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    var name = data["ingredient_Name"] as? String ?? "Anonymous"
                    let units = data["units"] as? String ?? ""
                    let expirydate = data["Expiry_date"] as? String ?? ""
                    let amount = data["amount"] as? Float ?? 0
                    let ownerId = Auth.auth().currentUser?.uid ?? "" //MIGHT BE AN ERROR
                    let documentid = document.documentID
                    let category = data["Category"] as? String ?? ""
                    name = name.firstCapitalized
                    let newShoppinglistItem  = ShoppingListItem(name: name, amount: amount, units: units, documentid: documentid, ownerId: ownerId, category: category, expirydate: expirydate)
                    if !self.shoppinglistnames.contains(name) {
                        self.shoppinglist.append(newShoppinglistItem)
                    }
                    
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//
//                    }
                    self.shoppinglistnames = self.updateShoppingListNamesArray(shoppinglist: self.shoppinglist)
//                    self.shoppinglistnames.append(name)
//                    print(self.shoppinglistnames)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func updateShoppingListNamesArray(shoppinglist: [ShoppingListItem]) -> [String] {
        var shoppingListNamesArray = [String]()
        for i in shoppinglist {
            shoppingListNamesArray.append(i.name)
        }
        return shoppingListNamesArray
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        shoppingListener.remove()
        searchController.searchBar.text = ""
        searchController.dismiss(animated: false, completion: nil)
        self.searchController.searchBar.showsCancelButton = false
        searchController.isActive = false
    }
    
//    func configureCell(shoppinglist: ShoppingList){
//
//    }
    
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
            filteredItemsNames = shoppinglistnames.filter { name in return name.lowercased().contains(searchText.lowercased()) }
        } else{
            filteredItemsNames = shoppinglistnames
        }
        tableView.reloadData()
    }
 
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fooditems: [String]?
        if searchController.isActive {
            fooditems = filteredItemsNames
        } else {
            
            fooditems = shoppinglistnames
        }
        
        return fooditems?.count ?? 0
//        print(fooditems.count)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        let shpinglistnames: [String]?
        shpinglistnames = shoppinglistnames
        if searchController.isActive {
            if let fooditems = filteredItemsNames {
                let food = fooditems[indexPath.row]
                
                cell.textLabel?.text = food
                
            }
        } else {
            if let fooditems = shpinglistnames {
                let food = fooditems[indexPath.row]
                
                cell.textLabel?.text = food
                
            }
        }
        

        
        return cell
    }
    // END Table View Configurations
 
    // SwipeTableViewCell delegate functions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        var item: ShoppingListItem!
        if (searchController.isActive) {
            let mystring = filteredItemsNames![indexPath.row]
            for j in shoppinglist {
                if j.name == mystring {
                    item = j
                }
            }
        } else {
            item = shoppinglist[indexPath.row]
        }
        

        if orientation == .left {
            guard isSwipeRightEnabled else { return nil}

            let buyitem = SwipeAction(style: .default, title: nil, handler: {action, indexPath in
//                item.isBought = !item.isBought
//                item.up
            

                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                let user = Auth.auth().currentUser?.uid
                
                db.collection("FreshList_Ingredients").document().setData ([
                    "Ingredient_name": item.name,
                    "Quantity": item.amount,
                    "Category": item.category,
                    "Expiry_date": item.expirydate,
                    "ownerId": Auth.auth().currentUser?.uid,
                    "documentid": item.documentid,
                    "units": item.units,
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                                KRProgressHUD.showMessage("Item Added to Pantry")
                        }
                    }

                if (self.searchController.isActive) {
                    self.filteredItemsNames?.remove(at: indexPath.row)
                    self.shoppinglist.remove(at: indexPath.row)
                    self.deleteItemInBackground(shoppingListItem: item)
                 

                } else {
                    self.shoppinglist.remove(at: indexPath.row)
                    self.filteredItemsNames?.remove(at: indexPath.row)
                    self.deleteItemInBackground(shoppingListItem: item)
                    

                }
                tableView.reloadData()
                })
         /*   buyitem.accessibilityLabel = item.isBought ? "Bought" : "Return"*/
            let descriptor: ActionDescriptor = item.isBought ? .returnitem : .bought
            configure(action: buyitem, with: descriptor)
            return[buyitem]
        } else {
            let delete = SwipeAction(style: .destructive, title: nil, handler: { (action, indexPath) in
                //print(item.documentid)
               
                //self.shoppinglistnames.remove(at: indexPath.row)
                if (self.searchController.isActive) {
                    self.filteredItemsNames?.remove(at: indexPath.row)
                    self.shoppinglist.remove(at: indexPath.row)
                    self.deleteItemInBackground(shoppingListItem: item)
                    KRProgressHUD.showError(withMessage: "Item has been deleted")
                } else {
                    self.shoppinglist.remove(at: indexPath.row)
                    self.filteredItemsNames = self.shoppinglistnames
                    self.shoppinglistnames.remove(at: indexPath.row)
                    self.filteredItemsNames?.remove(at: indexPath.row)
                    self.deleteItemInBackground(shoppingListItem: item)
                    KRProgressHUD.showError(withMessage: "Item has been deleted")
                }
                

                self.tableView.beginUpdates()
                action.fulfill(with: .delete)
                self.tableView.endUpdates()
            })
            configure(action: delete, with: .trash)
            return[delete]
        }
    }

    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title()
        action.image = descriptor.image()
        action.backgroundColor = descriptor.color
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {

        var options = SwipeTableOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        options.buttonSpacing = 11

        return options
    }


    func deleteItemInBackground(shoppingListItem: ShoppingListItem) {

        Firestore.firestore().collection(kSHOPPINGLIST).document(shoppingListItem.documentid).delete { (Error) in
            if let err = Error {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed")
            }
        }
    }
}
