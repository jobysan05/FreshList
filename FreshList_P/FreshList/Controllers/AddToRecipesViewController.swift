//
//  AddToRecipesViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

// TODO: Add field to take in user pic, if no pic set pic to default picture.

import UIKit
import Firebase
import FirebaseFirestore

class AddToRecipesViewController: UIViewController {
    
    // Configure inputs container
    let recipeInputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Configure recipe name text field
    let recipeNameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Recipe Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under recipe name text field
    let recipeNameSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    // Configure ingredients label
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients: "
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Configure ingredients text field
    let ingredientTextField: UITextView = {
        let tf = UITextView()
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Helvetica", size: 18.0)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 6.0
        tf.layer.borderWidth = 0.5
        
        return tf
    }()
    
    // Configure instructions label
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructions: "
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipeInstructionsTextField: UITextView = {
        let tf = UITextView()
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Helvetica", size: 18.0)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 6.0
        tf.layer.borderWidth = 0.5
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(recipeInputsContainerView)
        setupView()
        setupNavigationBar(title: "Add Recipe")
        setupInputsContainerView()
        
    }
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
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
        let addItemButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleConfirmAdd))
        addItemButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = addItemButton
    }
    // Function called to add item to user's ingredients
    @objc private func handleConfirmAdd() {
        // TODO: Add firebase functionality to save item to user ingredients table
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("FreshList_Add_Recipes").addDocument(data: [
            "recipe_Name": recipeNameTextField.text!,
            "recipe_Instructions": recipeInstructionsTextField.text!,
            "recipe_Ingredients": ingredientTextField.text!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupInputsContainerView() {
        // Set up X, Y, width, and height constraints for inputs container
        recipeInputsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        recipeInputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        recipeInputsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -24).isActive = true
        recipeInputsContainerView.addSubview(recipeNameTextField)
        // Set up X, Y, width, and height constraints for recipe name text field
        recipeNameTextField.leftAnchor.constraint(equalTo: recipeInputsContainerView.leftAnchor, constant: 12).isActive = true
        recipeNameTextField.topAnchor.constraint(equalTo: recipeInputsContainerView.topAnchor).isActive = true
        recipeNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        recipeNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        recipeInputsContainerView.addSubview(recipeNameSeparatorView)
        // Set up X, Y, width, and height constraints for line under recipe name field
        recipeNameSeparatorView.leftAnchor.constraint(equalTo: recipeInputsContainerView.leftAnchor, constant: 12).isActive = true
        recipeNameSeparatorView.topAnchor.constraint(equalTo: recipeNameTextField.bottomAnchor).isActive = true
        recipeNameSeparatorView.widthAnchor.constraint(equalTo: recipeNameTextField.widthAnchor).isActive = true
        recipeNameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        recipeInputsContainerView.addSubview(ingredientsLabel)
        // Set up X, Y, width, and height constraints for ingredients label
        ingredientsLabel.leftAnchor.constraint(equalTo: recipeInputsContainerView.leftAnchor, constant: 12).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: recipeNameTextField.bottomAnchor, constant: 40).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: recipeInputsContainerView.widthAnchor, constant: -12).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        recipeInputsContainerView.addSubview(ingredientTextField)
        // Set up X, Y, width, and height constraints for ingredients text field
        ingredientTextField.leftAnchor.constraint(equalTo: recipeInputsContainerView.leftAnchor, constant: 12).isActive = true
        ingredientTextField.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 4).isActive = true
        ingredientTextField.widthAnchor.constraint(equalTo: recipeInputsContainerView.widthAnchor, constant: -12).isActive = true
        ingredientTextField.heightAnchor.constraint(equalTo: recipeInputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        recipeInputsContainerView.addSubview(instructionsLabel)
        // Set up X, Y, width, and height constraints for instructions label
        instructionsLabel.leftAnchor.constraint(equalTo: recipeInputsContainerView.leftAnchor, constant: 12).isActive = true
        instructionsLabel.topAnchor.constraint(equalTo: ingredientTextField.bottomAnchor, constant: 40).isActive = true
        instructionsLabel.widthAnchor.constraint(equalTo: recipeInputsContainerView.widthAnchor, constant: -12).isActive = true
        instructionsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        recipeInputsContainerView.addSubview(recipeInstructionsTextField)
        // Set up X, Y, width, and height constraints for instructions text field
        recipeInstructionsTextField.leftAnchor.constraint(equalTo: recipeInputsContainerView.leftAnchor, constant: 12).isActive = true
        recipeInstructionsTextField.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 4).isActive = true
        recipeInstructionsTextField.widthAnchor.constraint(equalTo: recipeInputsContainerView.widthAnchor, constant: -12).isActive = true
        recipeInstructionsTextField.heightAnchor.constraint(equalTo: recipeInputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
}
