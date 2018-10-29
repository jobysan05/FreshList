//
//  RecipeCell.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/28/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

// Class for cells in collection view for Recipes view
class recipeCell: BaseCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recipe_img")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        var unselected = UIImage(named: "emptyheart")
        unselected = unselected?.maskWithColor(color: UIColor(r: 128, g: 171, b: 103))
        button.setImage(unselected, for: .normal)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lasagna"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Idk what to put here"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(favoriteButton)
        addSubview(recipeTitleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]", views: favoriteButton)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-0-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, favoriteButton, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: recipeTitleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: recipeTitleLabel, attribute: .left, relatedBy: .equal, toItem: favoriteButton, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: recipeTitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: recipeTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: recipeTitleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: favoriteButton, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}

