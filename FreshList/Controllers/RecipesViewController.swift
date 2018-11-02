//
//  RecipesViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecipesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    
    var recipes: [Recipe] = {
        var lasagnaRecipe = Recipe()
        lasagnaRecipe.title = "Lasagna"
        lasagnaRecipe.thumbnailImageString = "lasagna_img"
        lasagnaRecipe.briefDescription = "It's lasagna"
        
        var icecreamrecipe = Recipe()
        icecreamrecipe.title = "This is a really long recipe name to show the lines wrap"
        icecreamrecipe.thumbnailImageString = "icecream_img"
        icecreamrecipe.briefDescription = "It's ice cream"
        
        return [lasagnaRecipe, icecreamrecipe]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Recipes")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(RecipeCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        getData(query:"chicken%20breast", pageNumber:2)

    }
    func getData(query: String,pageNumber: Int) {
        let baseUrl = "https://www.food2fork.com/api/search?key=2a6e206cebcc3cde618dc5ca97b7e7b8&q=\(query)&page=\(pageNumber)"
        Alamofire.request(baseUrl, method: .get)
            .responseJSON { response in
                if response.data != nil {
                    do {
                        let json = try JSON(data: response.data!)
                        
                        let number = json["count"]
                        print("COUNT \(number)")
                        for i in 1...30 {
                            let name = json["recipes"][i]["title"].string
                            if name != nil {
                                // API LIMIT REACHED. Must buy access or find another free API
                                print(name!)
                            }
                        }
                    }
                    catch {
                        print("error to call")
                    }
                }
        }
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
        let addButton = setupAddRecipeButton()
        let searchButton = setupSearchButton()
        navigationItem.rightBarButtonItems = [addButton, searchButton]
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
    }
    
    // BEGIN configuration of cells in collectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RecipeCell
        cell.recipe = recipes[indexPath.item]
        
        // Configure the cell...
//        var querys = "chicken breast"
//        let replacedquery = querys.replacingOccurrences(of: " ", with: "%20",
//                                                        options: NSString.CompareOptions.literal, range:nil)
//        
//        
//        getData(query:replacedquery, pageNumber:3)
        print("recipe_data1recipe_data1")
        
        return cell    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * (9/16)
        return CGSize(width: view.frame.width, height: height + 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // END configuration for cells in collectionView
    
}