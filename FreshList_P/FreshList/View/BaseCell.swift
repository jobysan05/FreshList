//
//  BaseCell.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/29/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
