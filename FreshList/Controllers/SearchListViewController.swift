//
//  SearchListViewController.swift
//  FreshList
//
//  Created by Team7 on 11/30/18.
//  Copyright © 2018 Joby Santhoshj. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController, UISearchBarDelegate {

    var mySearchBar: UISearchBar!
    var searchlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //make UISearchBar instance
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.frame = CGRect(x: 0.0, y: 0.0, width: 300, height: 80)
        mySearchBar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 30)
        
        //add ashadow
//        mySearchBar.layer.shadowColor = (UIColor.black as! CGColor)
//        mySearchBar.layer.shadowOpacity = 0.5
//        mySearchBar.layer.masksToBounds = false
//
        // set Default bar status.
        mySearchBar.searchBarStyle = UISearchBar.Style.default
        
        // set title
        mySearchBar.prompt = "Search through the List"
        
        // set placeholder
        mySearchBar.placeholder = "Enter Item Name"
        
        // change the color of cursol and cancel button.
        mySearchBar.tintColor = UIColor.green
        // hide the search result.
        mySearchBar.showsSearchResultsButton = false
        
        // add searchBar to the view.
        self.view.addSubview(mySearchBar)
        
        // make UITextField
        searchlabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 30))
        searchlabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        searchlabel.text = ""
        searchlabel.layer.borderWidth = 1.0
        //searchlabel.layer.borderColor = UIColor.green
        searchlabel.layer.cornerRadius = 10.0
        
        // add the label to the view.
        self.view.addSubview(searchlabel)
        self.navigationController?.navigationBar.addSubview(searchlabel)
    }
    
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchlabel.text = searchText
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchlabel.text = ""
        mySearchBar.text = ""
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchlabel.text = "Searching"
        mySearchBar.text = ""
        self.view.endEditing(true)
    }
}
