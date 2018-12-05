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
    case bought, returnitem, trash
    
    func title() -> String? {
        
        switch self {
        case.bought: return "Bought"
        case.returnitem: return "Return"
        case.trash: return "Trash"
            
        }
    }
    
    func image() -> UIImage? {
        let name: String
        
        switch self {
        case .bought: name = "BuyFilled"
        case .returnitem: name = "ReturnFilled"
        case .trash: name = "Trash"
            
        }
        return UIImage(named: name)
    }
    
    var color: UIColor {
        
        switch self {
        case .bought, .returnitem: return UIColor(r: 128, g: 171, b: 103)
        case .trash: return .red
            
        }
    }
}

func createSelectedBackgroundView() -> UIView {
    
    let view = UIView()
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    return view
}
