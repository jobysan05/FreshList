//
//  StatsViewController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/23/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar(title: "Statistics")
        
    }
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    private func setupNavigationBar(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        // Call function to add buttons to navigation bar
        setupNavigationBarItems()
    }
    
    // Function called to set up buttons in navigation bar
    private func setupNavigationBarItems() {
    }
    
    
}