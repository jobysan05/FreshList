//
//  IngredientList.swift
//  FreshList
//
//  Created by Team7 on 12/4/18.
//  Copyright © 2018 Abhi Kumar. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class IngredientList {
    let ingredientname: String
    let quantity: Float
    var units: String
    let category: String
    var expirydate: String
    var documentid: String
    var ownerId: String    //To know which owner the item belongs to
    var isBought: Bool
    
    init(ingredientname: String, quantity: Float = 0, category: String = "", expirydate: String = "", documentid: String, ownerId: String, units: String = "") {
        self.ingredientname = ingredientname
        self.quantity = quantity
        self.category = category
        self.expirydate = expirydate
        self.documentid = documentid
        self.ownerId = ownerId
        isBought = false
        self.units = units
    }
    
}
