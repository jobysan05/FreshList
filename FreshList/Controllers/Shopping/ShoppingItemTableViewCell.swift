//
//  ShoppingItemTableViewCell.swift
//  FreshList
//
//  Created by Team7 on 12/5/18.
//  Copyright © 2018 Abhi Kumar. All rights reserved.
//

import UIKit
import SwipeCellKit

class ShoppingItemTableViewCell: SwipeTableViewCell {
    
    let ingredientNameLabel: UILabel = {
        let ingLabel = UILabel()
        ingLabel.text = ""
        ingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return ingLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        contentView.addSubview(ingredientNameLabel)
        setupIngredientLabel()
        let viewsDict = [
            "name": self.ingredientNameLabel
        ]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setupIngredientLabel() {
//        ingredientNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        ingredientNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        ingredientNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: ingredientNameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: ingredientNameLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func bindData(item: ShoppingList) {
        
    }
    
}
