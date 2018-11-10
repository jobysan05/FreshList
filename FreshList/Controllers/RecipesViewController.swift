//
//  RecipesViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit

class RecipesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupMenuBar()
        setupNavigationBar(title: "Recipes")
    }
    private func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(RecipeFeedCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
    }
    
    // BEGIN setup of menu bar
    lazy var recipesMenuBar: RecipesMenuBar = {
        let menubar = RecipesMenuBar()
        menubar.recipesViewController = self
        return menubar
    }()
    
    private func setupMenuBar() {
        let greenView = UIView()
        greenView.backgroundColor = UIColor(r: 128, g: 171, b: 103)
        
        view.addSubview(greenView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: greenView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: greenView)
        
        view.addSubview(recipesMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: recipesMenuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: recipesMenuBar)
        
        recipesMenuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        recipesMenuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    // END setup of menu bar
    
    // Function called to set up Navigation Bar
    private func setupNavigationBar(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        setupNavigationBarItems()
    }
    // Function called to set up items in Navigation Bar
    private func setupNavigationBarItems() {
        let addButton = setupAddRecipeButton()
        let searchButton = setupSearchButton()
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = searchButton
    }
    
    // Function to set up add item button in navigation bar
    private func setupAddRecipeButton() -> UIBarButtonItem {
        // Configuration for add ingredient button
        let addItemButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(handleAddRecipe))
        addItemButton.tintColor = UIColor.white
        return addItemButton
    }
    
    // Function called by addItemButton to show AddItemView
    @objc private func handleAddRecipe() {
        let addIngredientController = AddToRecipesViewController()
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
        scrollToMenuIndex(menuIndex: 1)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    // BEGIN configuration of cells in collectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        recipesMenuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}
