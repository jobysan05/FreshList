//
//  AddToShoppingListViewController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import KRProgressHUD

// TODO: add protocol/delegate functionality for firebase auth 
// TODO: add protocol/delegate functionality for adding item to ShoppingListViewController user list.


class AddToShoppingListViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    
    // Configure inputs container
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Configure ingredient name text field
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Ingredient Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under name text field
    let nameSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    // Configure ingredient amount text field
    let amountTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under amount text field
    let amountSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    // Configure unit text field
    let unitTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Units", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under unit text field
    let unitSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(inputsContainerView)
        
        setupView()
        setupNavigationBar(title: "Add Item")
        setupInputsContainerView()
        
    }
    // Function to setup basic view elements
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    // Function to set up navigation bar
    private func setupNavigationBar(title: String) {
        // Configure navigation bar title
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        setupNavigationBarItems()
    }
    
    // Function to set up items in navigation bar
    private func setupNavigationBarItems() {
        let addItemButton = setupAddItemButton()
        navigationItem.rightBarButtonItem = addItemButton
    }
    
    // Function to set up add item button in navigation bar
    private func setupAddItemButton() -> UIBarButtonItem {
        // Configuration for add ingredient button
        let addItemButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(handleConfirmAdd))
        addItemButton.tintColor = UIColor.white
        return addItemButton
    }
    // Function called to add item to user's ingredients
    @objc private func handleConfirmAdd() {
        //let myRef = db.collection("cShopping_Lists")
        //let secondRef = db.collection("second_collection")
        // let tempId = myRef.document().documentID
        //myRef.document(tempId).setData(myDictionary)
        //secondRef.document(tempId).setData(otherDictionary)
        //let fUser = ShoppingList(_id: Auth.auth().currentUser?.uid, , )
        
        addItemToShoppingList(db: self.db)
        
    }
    
    func addItemToShoppingList(db: Firestore) {
        var shoppinglist = [String]()
        let shoppingListCollectionRef = Firestore.firestore().collection(kSHOPPINGLIST)
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
                    let id = data["shoppingListId"] as? String ?? ""
                    
                    let newShoppinglistItem  = ShoppingList(_name: name, _amount: amount, _units: units, id: id, ownerId: ownerId)
                    if !shoppinglist.contains(name) { shoppinglist.append(newShoppinglistItem.name) }
                }
            }
            var ref: DocumentReference? = nil
            if !shoppinglist.contains(self.nameTextField.text!){
                ref = db.collection("Shopping_Lists").addDocument(data: [
                    "ingredient_Name": self.nameTextField.text!,
                    "amount": self.amountTextField.text!,
                    "units": self.unitTextField.text!,
                    "ownerId": Auth.auth().currentUser?.uid,
                    "shoppingListId": ref?.documentID
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        KRProgressHUD.showSuccess(withMessage: "Item has been added to the cart")
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                self.popBack(toControllerType: ShoppingListViewController.self)
            }
            else {
                KRProgressHUD.showWarning(withMessage: "Item already exists in your cart")
            }
        }
        
    }
    
    // Function to setup inputs container and text fields within
    private func setupInputsContainerView() {
        // Set up X, Y, width, and height constraints for inputs container
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        // Set up X, Y, width, and height constraints for name text field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(nameSeparatorView)
        // Set up X, Y, width, and height constraints for line under name field
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(amountTextField)
        // Set up X, Y, width, and height constraints for amount text field
        amountTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        amountTextField.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(amountSeparatorView)
        // Set up X, Y, width, and height constraints for line under amount field
        amountSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        amountSeparatorView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor).isActive = true
        amountSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        amountSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(unitTextField)
        // Set up X, Y, width, and height constraints for unit text field
        unitTextField.leftAnchor.constraint(equalTo: amountTextField.rightAnchor, constant: 8).isActive = true
        unitTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/5).isActive = true
        unitTextField.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        unitTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(unitSeparatorView)
        // Set up X, Y, width, and height constraints for line under unit field
        unitSeparatorView.leftAnchor.constraint(equalTo: amountSeparatorView.rightAnchor, constant: 8).isActive = true
        unitSeparatorView.topAnchor.constraint(equalTo: unitTextField.bottomAnchor).isActive = true
        unitSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/5).isActive = true
        unitSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
