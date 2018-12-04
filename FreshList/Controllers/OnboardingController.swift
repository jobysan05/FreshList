//
//  OnboardingController.swift
//  FreshList
//
//  Copyright © ubiqteam7fall 2018 . All rights reserved.
//

import UIKit

class OnboardingController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellID: String = "cellID"
    let loginCellID: String = "loginCellID"
    
    let pages: [OnboardingPage] = {
        let firstPage = OnboardingPage(title: "Welcome To Freshlist", message: "FreshList is an app that makes your time in the kitchen simpler and enjoyable.", imageName: "icons8-organic-food-480")
        let secondPage = OnboardingPage(title: "Lists on lists on lists", message: "Create and manage shopping lists, lists of what's in your pantry, lists of recipes, and more!", imageName: "icons8-ingredients-480")
        let thirdPage = OnboardingPage(title: "Don't think, just cook", message: "FreshList provides you with an endless supply of recipes to choose from. Cook all the things!", imageName: "icons8-cooking-book-480")
        let fourthPage = OnboardingPage(title: "Shop with ease", message: "FreshList provides you with a barcode scanner as well as object detection to make your time at the store hassle-free.", imageName: "bardetect")
        
        return [firstPage, secondPage, thirdPage, fourthPage]
    }()
    
    lazy var onboardingCV: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        let darkGreen = UIColor(r: 48,g: 89, b: 23)
        pc.currentPageIndicatorTintColor = darkGreen
        pc.numberOfPages = self.pages.count + 1
        
        return pc
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        let darkGreen = UIColor(r: 48,g: 89, b: 23)
        button.setTitle("Skip", for: .normal)
        button.titleLabel!.font = UIFont(name: "Helvetica", size: 18)
        button.setTitleColor(darkGreen, for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSkip() {
        pageControl.currentPage = pages.count - 1
        handleNextPage()
    }
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let darkGreen = UIColor(r: 48,g: 89, b: 23)
        button.setTitle("Next", for: .normal)
        button.titleLabel!.font = UIFont(name: "Helvetica", size: 18)
        button.setTitleColor(darkGreen, for: .normal)
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleNextPage() {
        if pageControl.currentPage == pages.count { return }
        if pageControl.currentPage == pages.count - 1 { movePageControlElementsOffScreen() }
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        onboardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardOnTap()
        
        observeKeyboardNotifications()
        
        view.addSubview(onboardingCV)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        setupSubviews()
        
        registerCells()
        
    }
    
    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -60, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        print("Keyboard Shown")
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count {
            movePageControlElementsOffScreen()
        } else {
            bringBackPageControlElementsOnScreen()
        }
        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
    }
    
    private func movePageControlElementsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func bringBackPageControlElementsOnScreen() {
        pageControlBottomAnchor?.constant = 0
        skipButtonTopAnchor?.constant = 16
        nextButtonTopAnchor?.constant = 16
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func registerCells() {
        onboardingCV.register(OnboardingPageCell.self, forCellWithReuseIdentifier: cellID)
        onboardingCV.register(LoginCell.self, forCellWithReuseIdentifier: loginCellID)
    }
    
    func setupSubviews() {
        setupOnboardingCV()
        setupPageControl()
        setupSkipButton()
        setupNextButton()
    }
    func setupOnboardingCV() {
        onboardingCV.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func setupPageControl() {
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
    }
    
    func setupSkipButton() {
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
    }
    
    func setupNextButton() {
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
    }
    
    // Functions to set up parameters for Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellID, for: indexPath)
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OnboardingPageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        
        return size
    }
}
