//
//  RecipeFeedCell.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class RecipeFeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var recipes: [Recipe]?
    
    let cellID = "cellID"
    
    func fetchRecipes() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        db.collection("FreshList_Add_Recipes").whereField("ownerId", isEqualTo: user!).addSnapshotListener { documentSnapshot, error in
            guard let doc_val = documentSnapshot else {
                return
            }
            for doc in doc_val.documents {
                let data = doc.data()
                let recipeName = data["recipe_Name"] as? String ?? ""
                let recipeInstructions = data["recipe_Instructions"] as? String ?? ""
                let recipeIngredients = data["recipe_Ingredients"] as? String ?? ""
                let newRecipe = Recipe(title: recipeName, recipeIngredients: recipeIngredients, recipeInstructions: recipeInstructions, thumbnailImageString: "", briefDescription: "")
                print("\(recipeName)")
                self.recipes?.append(newRecipe)
                for i in self.recipes! {
                    print(i.title)
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        fetchRecipes()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    // BEGIN configuration of cells in collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchRecipes()
        return recipes!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RecipeCell
        cell.recipe = recipes![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 32) * (9/16)
        return CGSize(width: frame.width, height: height + 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // END configuration for cells in collectionView
}
