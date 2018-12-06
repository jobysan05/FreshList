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
import Foundation
import Firebase
import SwipeCellKit
import KRProgressHUD

class IngredientsViewController: UITableViewController, UISearchResultsUpdating, SwipeTableViewCellDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    var filteredItemsNames1: [String]?
    var ingredientlistnames = [String]()
    var ingredientlist = [IngredientList]()
    var ingredientListCollectionRef: CollectionReference!
    var ingredientListener: ListenerRegistration!
    
    var defaultOptions = SwipeTableOptions()
    var isSwipeRightEnabled = true
    
    let cellID = "cellID"

    override func viewDidLoad() {
        ingredientListCollectionRef = Firestore.firestore().collection(kIngredients)
        
        filteredItemsNames1 = ingredientlistnames
        print(filteredItemsNames1!.count)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        searchController.searchBar.placeholder = "Search for an item"
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        super.viewDidLoad()
        setupNavigationBar(title: "Pantry")
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pullfromDBAndUpdate()
    }
    
    func pullfromDBAndUpdate() {
        //print("I have been called pull and update")
        ingredientListener = ingredientListCollectionRef
            .order(by: kINGREDIENTNAMEZ, descending: false)
            .addSnapshotListener { (snapshot, error) in // looks dynamically for changes made to the app and refreshethe app
                if let err = error {
                    debugPrint("Error fetching docs: \(err)")
                } else {
                    self.ingredientlist.removeAll()                                   // changes wont just add to the app but replace it
                    guard let snap = snapshot else { return }
                    for document in snap.documents {
                        let data = document.data()
                        var ingredientname = data["Ingredient_name"] as? String ?? "Anonymous"
                        let category = data["Category"] as? String ?? ""
                        let quantity = data["Quantity"] as? Float ?? 0
                        let ownerId = Auth.auth().currentUser?.uid ?? "" //MIGHT BE AN ERROR
                        let expirydate = data["Expiry_date"] as? String ?? ""
                        let documentid = document.documentID
                        let units = data["units"] as? String ?? ""
                        ingredientname = ingredientname.firstCapitalized
                        let newIngredientListItems  = IngredientList(ingredientname: ingredientname, quantity: quantity, category: category, expirydate:expirydate, documentid: documentid, ownerId: ownerId, units: units)
                        if !self.ingredientlistnames.contains(ingredientname) {
                            self.ingredientlist.append(newIngredientListItems)
                        }
                        self.ingredientlistnames = self.updateIngredientListNamesArray(ingredientlist: self.ingredientlist)
                    }
                    
                    self.tableView.reloadData()
                }
        }
    }
    
    func updateIngredientListNamesArray(ingredientlist: [IngredientList]) -> [String] {
        var ingredientListNamesArray = [String]()
        for i in ingredientlist {
            ingredientListNamesArray.append(i.ingredientname)
        }
        return ingredientListNamesArray
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ingredientListener.remove()
        searchController.searchBar.text = ""
        searchController.dismiss(animated: false, completion: nil)
        self.searchController.searchBar.showsCancelButton = false
        searchController.isActive = false
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
        let addItemButton = setupAddItemButton()
        let barcodeButton = setupBarcodeButton()
        navigationItem.rightBarButtonItems = [addItemButton, barcodeButton]
        
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
            filteredItemsNames1 = ingredientlistnames.filter { name in return name.lowercased().contains(searchText.lowercased()) }
        } else{
            filteredItemsNames1 = ingredientlistnames
        }
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fooditems: [String]?
        if searchController.isActive {
            fooditems = filteredItemsNames1
        } else {
            
            fooditems = ingredientlistnames
        }
        
        return fooditems?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        let shpinglistnames: [String]?
        shpinglistnames = ingredientlistnames
        if searchController.isActive {
            if let fooditems = filteredItemsNames1 {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    // END Table View configurations
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        var item: IngredientList!
        if (searchController.isActive) {
            let mystring = filteredItemsNames1![indexPath.row]
            for j in ingredientlist {
                if j.ingredientname == mystring {
                    item = j
                }
            }
        } else {
            item = ingredientlist[indexPath.row]
        }
        
        
        if orientation == .left {
            guard isSwipeRightEnabled else { return nil}
            
            let buyitem = SwipeAction(style: .default, title: nil, handler: {action, indexPath in
                //                item.isBought = !item.isBought
                //                item.up
                
                
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                let user = Auth.auth().currentUser?.uid
                
                db.collection("Shopping_Lists").document().setData ([
                    "ingredient_Name": item.ingredientname,
                    "Quantity": item.quantity,
                    "Category": item.category,
                    "Expiry_date": item.expirydate,
                    "units": item.units,
                    "documentid": item.documentid,
                    "ownerId": Auth.auth().currentUser?.uid,
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            KRProgressHUD.showMessage("Item Added to Shopping List")

                        }
                }
                print(item.ingredientname)
                if (self.searchController.isActive) {
                    self.filteredItemsNames1?.remove(at: indexPath.row)
                    self.ingredientlist.remove(at: indexPath.row)
                    self.deleteItemInBackground1(ig: item)
                   

                } else {
                    
                    self.ingredientlist.remove(at: indexPath.row)
                    self.filteredItemsNames1 = self.ingredientlistnames
                    self.filteredItemsNames1?.remove(at: indexPath.row)
                    self.ingredientlistnames.remove(at: indexPath.row)
                    self.deleteItemInBackground1(ig: item)
                    

                }
                tableView.reloadData()
            })
           /* buyitem.accessibilityLabel = item.isBought ? "Bought" : "Return"*/
            let descriptor: ActionDescriptor = item.isBought ? .returnitem : .bought
            configure(action: buyitem, with: descriptor)
            return[buyitem]
        } else {
            let delete = SwipeAction(style: .destructive, title: nil, handler: { (action, indexPath) in
                print(item.documentid)
                
                //self.shoppinglistnames.remove(at: indexPath.row)
                if (self.searchController.isActive) {
                    self.filteredItemsNames1?.remove(at: indexPath.row)
                    self.ingredientlist.remove(at: indexPath.row)
                    self.deleteItemInBackground1(ig: item)
                     KRProgressHUD.showError(withMessage: "Item has been deleted")
                } else {
                    self.ingredientlist.remove(at: indexPath.row)
                    self.filteredItemsNames1 = self.ingredientlistnames
                    self.filteredItemsNames1?.remove(at: indexPath.row)
                    self.ingredientlistnames.remove(at: indexPath.row)
                    self.deleteItemInBackground1(ig: item)
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
    
    
    func deleteItemInBackground1(ig: IngredientList) {
        
        Firestore.firestore().collection(kIngredients).document(ig.documentid).delete { (Error) in
            if let err = Error {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed")
            }
        }
    }
    
}
