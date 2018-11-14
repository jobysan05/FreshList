//
//  RecipeMenuBarCell.swift
//  FreshList
//
//  Copyright © 2018 Aubiqteam7fall. All rights reserved.
//

import UIKit

class RecipeMenuBarCell: BaseCell {
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "test"
        lbl.textColor = UIColor(r: 48,g: 89, b: 23)
        lbl.font = UIFont(name: "Arial-BoldMT", size: 18.0)
        return lbl
    }()
    
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? UIColor.white : UIColor(r: 48,g: 89, b: 23)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? UIColor.white : UIColor(r: 48,g: 89, b: 23)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        addConstraintsWithFormat(format: "H:[v0]", views: label)
        addConstraintsWithFormat(format: "V:[v0]", views: label)
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
