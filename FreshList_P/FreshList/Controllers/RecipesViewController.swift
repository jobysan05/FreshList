//
//  RecipesViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class RecipesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(title: "Recipes")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(recipeCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
    }
    
    // BEGIN setup of menu bar
    let menuBar: MenuBar = {
        let menubar = MenuBar()
        
        return menubar
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    // END setup of menu bar
    
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
        setupAddRecipeButton()
    }
    
    // Function to set up add item button in navigation bar
    private func setupAddRecipeButton() {
        // Configuration for add ingredient button
        let addItemButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(handleAddRecipe))
        addItemButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = addItemButton
    }
    
    // Function called by addItemButton to show AddItemView
    @objc private func handleAddRecipe() {
        let addIngredientController = AddToRecipesViewController()
        navigationController?.pushViewController(addIngredientController, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    // BEGIN configuration of cells in collectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * (9/16)
        return CGSize(width: view.frame.width, height: height + 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // END configuration for cells in collectionView
    
}
