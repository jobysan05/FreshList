//
//  AddToIngredientsViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class AddToIngredientsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar(title: "Add Item")
        
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
    }
    
}
