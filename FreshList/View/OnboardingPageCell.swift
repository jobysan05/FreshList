//
//  OnboardingPageCell.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit

class OnboardingPageCell: UICollectionViewCell {
    
    var page: OnboardingPage? {
        didSet {
            guard let page = page else {
                return
            }
            imageView.image = UIImage(named: page.imageName)
            
            let darkGreen = UIColor(r: 48,g: 89, b: 23)
            let darkGray = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedString.Key.foregroundColor: darkGreen])
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: darkGray]))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCells()
    }
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .white
        let image = UIImage(named: "icons8-organic-food-480")
        imgView.image = image
        
        return imgView
    }()
    
    let textView: UITextView = {
        let txtView = UITextView()
        txtView.text = "Test"
        txtView.backgroundColor = .white
        txtView.isEditable = false
        txtView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        return txtView
    }()
    
    func setupCells() {
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(textView)
        
        setupImageView()
        setupTextView()
    }
    
    func setupImageView() {
        imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    }
    
    func setupTextView() {
        textView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
