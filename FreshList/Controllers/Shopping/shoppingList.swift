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

class ShoppingList {
    let name: String
    let amount: Float
    let units: String
    var id: String
    var ownerId: String //To know which owner the item belongs to
    var isBought: Bool
    
    init(_name: String, _amount: Float = 0, _units: String = "", id: String, ownerId: String) {
        name = _name
        amount = _amount
        units = _units
        self.id = id
        self.ownerId = ownerId
        isBought = false
    }
    
    init(dictionary: NSDictionary) {
        name = dictionary[kNAME] as! String
        amount = dictionary[kAMOUNT] as! Float
        units = dictionary[kUNITS] as! String
        id = dictionary[kSHOPPINGLISTID] as! String
        ownerId = dictionary[kOWNERID] as! String
        isBought = dictionary[kISBOUGHT] as! Bool
    }
    
    func dictionaryFromitem(item: ShoppingList) -> NSDictionary {
        return NSDictionary(objects: [item.name, item.amount, item.units, item.id, item.ownerId], forKeys: [kNAME as NSCopying, kAMOUNT as NSCopying, kUNITS as NSCopying, kSHOPPINGLISTID as NSCopying, kOWNERID as NSCopying])
    }
    
//    func saveItemInBackground(shoppingList: ShoppingList, completion: @escaping (_ error: Error?) -> Void)
//    {
//        Firestore.firestore().collection("Shopping_Lists").document(ownerId).setData(dictionaryFromitem(item: shoppingList) as! [String : Any]) { (Error) in
//            if Error != nil {
//                print("error saving to firestore")
//                return
//            }
//            print("...... created in firebase")
//        }
////        ref.setData(dictionaryFromitem(item: shoppingList) as! [String : Any], merge: true, completion: (Error))(dictionaryFromitem(item: shoppingList)) { (error, ref) -> Void in
////            completion(error)
////
//    }
//
//
    func deleteItemInBackground(shoppingList: ShoppingList) {

        Firestore.firestore().collection(kSHOPPINGLIST).document(shoppingList.id).delete(completion: { (error) in
            if let error = error {
                    debugPrint("Could not delete")
                }
                else {
                    print("successful deletion")
                }
        })
    }
//

}



