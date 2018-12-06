//
//  SwipeTableViewHelpers.swift
//  FreshList
//
//  Created by Team7 on 12/4/18.
//  Copyright © 2018 Abhi Kumar. All rights reserved.
//

import Foundation
import UIKit

enum ActionDescriptor {
    case bought, returnitem, trash, pantry, list
    
    func title() -> String? {
        
        switch self {
        case.bought: return "Bought"
        case.returnitem: return "Return"
        case.trash: return "Trash"
        case .pantry: return "ChecklistFilled"
        case .list: return "ShoppingCartFull"
            
        }
    }
    
    func image() -> UIImage? {
        let name: String
        
        switch self {
        case .bought: name = "BuyFilled"
        case .returnitem: name = "ReturnFilled"
        case .trash: name = "Trash"
        case .pantry: name = "ShoppingCartFull"
        case .list: name = "ChecklistFilled"
            
        }
        return UIImage(named: name)
    }
    
    var color: UIColor {
        
        switch self {
        case .bought, .returnitem: return UIColor(r: 128, g: 171, b: 103)
        case .trash: return .red
        case .pantry, .list: return UIColor(r: 128, g: 171, b: 103)
        
        }
    }
}

func createSelectedBackgroundView() -> UIView {
    
    let view = UIView()
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    return view
}
