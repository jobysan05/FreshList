//
//  CustomTabBarController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

// TODO: Maybe add delegate functionality for firebase user auth

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("Peekaboo!")
        if isLoggedIn() {
            // Assume user is logged in
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.0)
        }
    }
//     Function to check if user is already logged in
    fileprivate func isLoggedIn() -> Bool {
        return false
    }
    
    // Function to show loginController
    @objc func showLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: {
            // Maybe do something here later
        } )
    }
    
    // Function to set up bottom tab bar
    private func setupTabBar() {

        // Modifying the top border of the tab bar (making it less visible)
        let topBorder = CALayer()
        topBorder.frame.size.width = 1000
        topBorder.frame.size.height = 0.5
        topBorder.backgroundColor = UIColor(r: 221, g: 221, b: 221).cgColor
        // Change highlight color of tab bar buttons
        let darkGreen: UIColor = UIColor(r: 48,g: 89, b: 23)
        UITabBar.appearance().tintColor = darkGreen
        tabBar.clipsToBounds = true
        tabBar.layer.addSublayer(topBorder)
        setupTabBarItems()
    }

    // Function to set up tab buttons in tab bar
    private func setupTabBarItems() {
        
        // Shopping List Tab Button
        let shoppingListController = ShoppingListViewController()
        let shoppingListNavigationController = UINavigationController(rootViewController: shoppingListController)
        shoppingListNavigationController.title = "Shopping"
        shoppingListNavigationController.tabBarItem.image = UIImage(named: "shoppinglisticon")
        
        // Ingredients Tab Button
        let ingredientsController = IngredientsViewController()
        let ingredientsNavigationController = UINavigationController(rootViewController: ingredientsController)
        ingredientsNavigationController.title = "Ingredients"
        ingredientsNavigationController.tabBarItem.image = UIImage(named: "ingredientsicon")

        // Recipes List Tab Button
        let layout = UICollectionViewFlowLayout()
        let recipesController = RecipesViewController(collectionViewLayout: layout)
        let recipesNavigationController = UINavigationController(rootViewController: recipesController)
        recipesNavigationController.title = "Recipes"
        recipesNavigationController.tabBarItem.image = UIImage(named: "recipesicon")
        
        // Stats Tab Button
        let statsController = StatsViewController()
        let statsNavigationController = UINavigationController(rootViewController: statsController)
        statsNavigationController.title = "Statistics"
        statsNavigationController.tabBarItem.image = UIImage(named: "statsicon")
        
        // Account Tab Button
        let accountController = AccountViewController()
        let accountNavigationController = UINavigationController(rootViewController: accountController)
        accountNavigationController.title = "Account"
        accountNavigationController.tabBarItem.image = UIImage(named: "accounticon")
        
        viewControllers = [shoppingListNavigationController, ingredientsNavigationController, recipesNavigationController, statsNavigationController, accountNavigationController]
    }
}
