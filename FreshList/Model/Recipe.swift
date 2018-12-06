//
//  Recipe.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var thumbnailImageString: String?
    var title: String?
    var briefDescription: String?
    var recipeIngredients: String?
    var recipeInstructions: String?
//    var recipeDetails: RecipeDetails?
    
    init(title: String?, recipeIngredients: String?, recipeInstructions: String?, thumbnailImageString: String?, briefDescription: String?) {
        self.title = title
        self.recipeIngredients = recipeIngredients
        self.recipeInstructions = recipeInstructions
        self.thumbnailImageString = thumbnailImageString
        self.briefDescription = briefDescription
        
    }
}
