//
//  APIService.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIService: NSObject {

    static let sharedInstance = APIService()
    
    func getBarData(scannedCode: String, addShoppingController: AddToShoppingListViewController){
        let baseUrl = "https://api.upcitemdb.com/prod/trial/lookup?upc=\(scannedCode)"
        Alamofire.request(baseUrl, method: .get).responseJSON { response in
            if response.data != nil {
                do {
                    let json = try JSON(data: response.data!)
                    let name = json["items"][0]["title"].string
                    if name != nil {
                        addShoppingController.nameTextField.text = name
                    }
                }
                    
                catch {
                    print("error to call")
                }
            }
        }
    }
    
    func fetchRecipes(query: String,pageNumber: Int) { // , completion: ([Recipe]) -> ()
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
    
}
