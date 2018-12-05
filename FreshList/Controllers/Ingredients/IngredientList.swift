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
    let category: String
    var expirydate: Date
    var id: String
    var ownerId: String    //To know which owner the item belongs to
    
    init(_ingredientname: String, _quantity: Float = 0, _category: String = "", _expirydate: Date = Date(), _id: String = "") {
        ingredientname = _ingredientname
        quantity = _quantity
        category = _category
        expirydate = _expirydate
        id = _id
        ownerId = "1234"
    }
    
    init(dictionary: NSDictionary) {
        ingredientname = dictionary[kINGREDIENTNAME] as! String
        quantity = dictionary[kQUANTITY] as! Float
        category = dictionary[kCATEGORY] as! String
        expirydate = dictionary[kEXPIRYDATE] as! Date
        id = dictionary[kSHOPPINGLISTID] as! String
        ownerId = dictionary[kOWNERID] as! String
    }
    
    func dictionaryFromitem(item: ShoppingList) -> NSDictionary {
        return NSDictionary(objects: [item.name, item.amount, item.units, item.id, item.ownerId], forKeys: [kNAME as NSCopying, kAMOUNT as NSCopying, kUNITS as NSCopying, kSHOPPINGLISTID as NSCopying, kOWNERID as NSCopying])
    }
    
}
