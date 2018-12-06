//
//  shoppingList.swift
//  FreshList
//
//  Created by Team7 on 12/2/18.
//  Copyright © 2018 Joby Santhosh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ShoppingListItem {
    var name: String
    var amount: Float
    var units: String
    var documentid: String
    var ownerId: String //To know which owner the item belongs to
    var isBought: Bool
    var category: String
    var expirydate: String
    
    init(name: String, amount: Float = 0, units: String = "", documentid: String, ownerId: String, category: String = "", expirydate: String = "") {
        self.name = name
        self.amount = amount
        self.units = units
        self.documentid = documentid
        self.ownerId = ownerId
        isBought = false
        self.category = category
        self.expirydate = expirydate
    }

}
