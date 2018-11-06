//
//  RecipeFeedCell.swift
//  FreshList
//
//  Created by Abhinav Kumar on 11/6/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit

class RecipeFeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var recipes: [Recipe] = {
        var lasagnaRecipe = Recipe()
        lasagnaRecipe.title = "Lasagna"
        lasagnaRecipe.thumbnailImageString = "lasagna_img"
        lasagnaRecipe.briefDescription = "It's lasagna"
        
        var icecreamrecipe = Recipe()
        icecreamrecipe.title = "This is a really long recipe name to show the lines wrap"
        icecreamrecipe.thumbnailImageString = "icecream_img"
        icecreamrecipe.briefDescription = "It's ice cream"
        
        return [lasagnaRecipe, icecreamrecipe]
    }()
    
    let cellID = "cellID"
    
    func fetchRecipes() {
        // TODO: Implement APIService sharedInstance method here
    }
    
    override func setupViews() {
        super.setupViews()
        fetchRecipes()
//        fetchRecipes(query:"chicken%20breast", pageNumber:2)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    // BEGIN configuration of cells in collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RecipeCell
        cell.recipe = recipes[indexPath.item]
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(handleFavorite(sender:)), for: .touchUpInside)
        //        var querys = "chicken breast"
        //        let replacedquery = querys.replacingOccurrences(of: " ", with: "%20",
        //                                                        options: NSString.CompareOptions.literal, range:nil)
        //
        //
        //        getData(query:replacedquery, pageNumber:3)
        //        print("recipe_data1recipe_data1")
        return cell    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 32) * (9/16)
        return CGSize(width: frame.width, height: height + 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // END configuration for cells in collectionView
    
    // Function to add
    @objc private func handleFavorite(sender: UIButton) {
        if (sender.isSelected == true) {
            sender.isSelected = false
            // TODO: Add functionality to remove the recipe from that user's favorites list
        } else {
            sender.isSelected = true
            // TODO: Add functionality to add the recipe to that user's favorites list
        }
        print(sender.isSelected)
    }

    
}
