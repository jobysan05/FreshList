//
//  AddToIngredientsViewController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

// TODO: add protocol/delegate functionality for firebase auth
// TODO: add protocol/delegate functionality for adding item to IngredientsViewController user list.
// TODO: Figure out how to get rid of whitespace
    // Maybe make this view show up as a pop up on top of ingredients like in Out Of Milk when you click on item details for an item.

class AddToIngredientsViewController: UIViewController {
    
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
    
    // Configure expiry date text field
    // TODO: change to date input type
    let expiryDateTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Expiry Date", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under expiry date text field
    let expirySeparatorView: UIView = {
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
        setupAddItemButton()
    }
    
    
    // Function to set up add item button in navigation bar
    private func setupAddItemButton() {
        // Configuration for add ingredient button
        let addItemButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(handleConfirmAdd))
        addItemButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = addItemButton
    }
    // Function called to add item to user's ingredients
    @objc private func handleConfirmAdd() {
        // TODO: Add firebase functionality to save item to user ingredients table
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        let user = Auth.auth().currentUser?.uid
        db.collection("FreshList_Ingredients").document(user!).collection("ITEMS").document().setData ([
            "Ingredient_name": nameTextField.text!,
            "Quantity": amountTextField.text!,
            "Category": "Unknown",
            "Expiry_date": expiryDateTextField.text!,
            "ownerId": Auth.auth().currentUser?.uid,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // Function to setup inputs container and text fields within
    private func setupInputsContainerView() {
        // Set up X, Y, width, and height constraints for inputs container
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        // Set up X, Y, width, and height constraints for inputs container
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
        amountTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        amountTextField.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(amountSeparatorView)
        amountSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        amountSeparatorView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor).isActive = true
        amountSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        amountSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(unitTextField)
        unitTextField.leftAnchor.constraint(equalTo: amountTextField.rightAnchor, constant: 8).isActive = true
        unitTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/5).isActive = true
        unitTextField.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor).isActive = true
        unitTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(unitSeparatorView)
        unitSeparatorView.leftAnchor.constraint(equalTo: amountSeparatorView.rightAnchor, constant: 8).isActive = true
        unitSeparatorView.topAnchor.constraint(equalTo: unitTextField.bottomAnchor).isActive = true
        unitSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/5).isActive = true
        unitSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(expirySeparatorView)
        expirySeparatorView.bottomAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: -1).isActive = true
        expirySeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        expirySeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        expirySeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(expiryDateTextField)
        expiryDateTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        expiryDateTextField.bottomAnchor.constraint(equalTo: expirySeparatorView.topAnchor).isActive = true
        expiryDateTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        expiryDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
}
