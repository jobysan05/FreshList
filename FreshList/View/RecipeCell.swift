
//
//  RecipeCell.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//
import UIKit

// Class for cells in collection view for Recipes view
class RecipeCell: BaseCell {
    var recipeInstructions: String?
    var recipeIngredients: String?
    var recipe: Recipe? {
        didSet {
            if let recipeTitle = recipe?.title {
                recipeTitleLabel.text = recipeTitle
            }
            
            if let thumbnailImageString = recipe?.thumbnailImageString {
                thumbnailImageView.image = UIImage(named: thumbnailImageString)
            }
            
            if let description = recipe?.briefDescription {
                subtitleTextView.text = description
            }
            
            if let instructions = recipe?.recipeInstructions {
                self.recipeInstructions = instructions
            }
            
            if let ingredients = recipe?.recipeIngredients {
                self.recipeIngredients = ingredients
            }
            
            // Measuring title text
            if let recipeTitle = recipe?.title {
                let size = CGSize(width: frame.width - 8 - 44 - 8, height:  1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: recipeTitle).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 14)!], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-organic-food-480")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(recipeTitleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-0-|", views: recipeTitleLabel)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-0-[v0]-8-[v1]-28-[v2(1)]|", views: thumbnailImageView, recipeTitleLabel, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: recipeTitleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: recipeTitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: recipeTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: recipeTitleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}
