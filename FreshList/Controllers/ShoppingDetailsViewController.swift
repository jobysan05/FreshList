//
//  IngredientsDetailsViewController.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class ShoppingDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let units = ["None", "lbs", "qt", "pts", "oz", "cup", "gallon", "tbsp", "tsp", "mg", "g", "kg", "piece", "bag", "bottle", "box", "can", "each"]
    let categories =  ["None", "Dairy", "Grains", "Meat", "Fruits", "Vegetables", "Canned", "Other"]
    
    // Configure inputs container
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Configure ingredient name text field
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Ingredient Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under name text field
    let nameSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    // Configure ingredient amount text field
    let amountTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    // Configure line under amount text field
    let amountSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    // Configure line under expiry date text field
    let expirySeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    // Configure expiry date text field
    // TODO: change to date input type
    lazy var expiryDateTextField: UITextField = {
        let expTF = UITextField()
        expTF.textColor = UIColor.black
        expTF.attributedPlaceholder = NSAttributedString(string: "Expiry Date", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        expTF.translatesAutoresizingMaskIntoConstraints = false
        expTF.inputView = expiryDatePicker
        createToolbar(textField: expTF)
        
        return expTF
    }()
    
    lazy var expiryDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor(white: 0.97, alpha: 1)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        expiryDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    lazy var unitTextField: UITextField = {
        let uTextField = UITextField()
        uTextField.textColor = UIColor.black
        uTextField.attributedPlaceholder = NSAttributedString(string: "Units", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        uTextField.translatesAutoresizingMaskIntoConstraints = false
        uTextField.inputView = unitPicker
        createToolbar(textField: uTextField)
        
        return uTextField
    }()
    
    lazy var unitPicker: UIPickerView = {
        let unitPicker = UIPickerView()
        unitPicker.backgroundColor = UIColor(white: 0.97, alpha: 1)
        unitPicker.delegate = self
        return unitPicker
    }()
    
 
    let unitSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    lazy var categoryTextField: UITextField = {
        let cTextField = UITextField()
        cTextField.textColor = UIColor.black
        cTextField.attributedPlaceholder = NSAttributedString(string: "Category", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 180, g: 180, b: 180)])
        cTextField.translatesAutoresizingMaskIntoConstraints = false
        cTextField.inputView = catPicker
        createToolbar(textField: cTextField)
        
        return cTextField
    }()
    
    lazy var catPicker: UIPickerView = {
        let catPicker = UIPickerView()
        catPicker.backgroundColor = UIColor(white: 0.97, alpha: 1)
        catPicker.delegate = self
        return catPicker
    }()
    
    let categorySeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    
    func createToolbar(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor(white: 0.97, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(inputsContainerView)
        
        hideDatePickerOnTap()
        
        setupView()
        setupNavigationBar(title: "Edit Item")
        setupInputsContainerView()
        
    }
    // Function to setup basic view elements
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
    
    // Function to set up navigation bar
    private func setupNavigationBar(title: String) {
        // Configure navigation bar title
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 128, g: 171, b: 103)
        setupNavigationBarItems()
    }
    
    // Function to set up items in navigation bar
    private func setupNavigationBarItems() {
        let addItemButton = setupAddItemButton()
        navigationItem.rightBarButtonItem = addItemButton
    }
    
    // Function to set up add item button in navigation bar
    private func setupAddItemButton() -> UIBarButtonItem {
        // Configuration for add ingredient button
        let addItemButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleConfirmAdd))
        addItemButton.tintColor = UIColor.white
        return addItemButton
    }
    // Function called to add item to user's ingredients
    @objc private func handleConfirmAdd() {
        // TODO: Validate user input (date, empty fields, etc.)
        validateInput()
        
    }
    
    func validateInput() {
        if (nameTextField.text! == "" || amountTextField.text! == "") {
            let alertController = UIAlertController(title: "Missing fields!", message:
                "Please fill in at least ingredient name and amount.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        if let isInt = Int(amountTextField.text!) as Int? {
            print(isInt)
            pushToFireBase()
            self.popBack(toControllerType: ShoppingListViewController.self)
        } else if let isFloat = Float(amountTextField.text!) as Float? {
            print(isFloat)
            pushToFireBase()
            self.popBack(toControllerType: ShoppingListViewController.self)
        } else {
            let alertController = UIAlertController(title: "Incorrect input!", message:
                "The amount must be a number.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    func pushToFireBase() {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("Shopping_Lists").addDocument(data: [
            "ingredient_Name": nameTextField.text!,
            "amount": amountTextField.text!,
            "units": unitTextField.text!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // Function to setup inputs container and text fields within
    private func setupInputsContainerView() {
        // Set up X, Y, width, and height constraints for inputs container
        //        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        // Set up X, Y, width, and height constraints for inputs container
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(nameSeparatorView)
        // Set up X, Y, width, and height constraints for line under name field
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(amountTextField)
        amountTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        amountTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(amountSeparatorView)
        amountSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        amountSeparatorView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor).isActive = true
        amountSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        amountSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(unitTextField)
        unitTextField.leftAnchor.constraint(equalTo: amountTextField.rightAnchor, constant: 8).isActive = true
        unitTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40).isActive = true
        unitTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        unitTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputsContainerView.addSubview(unitSeparatorView)
        unitSeparatorView.leftAnchor.constraint(equalTo: amountTextField.rightAnchor, constant: 8).isActive = true
        unitSeparatorView.topAnchor.constraint(equalTo: unitTextField.bottomAnchor).isActive = true
        unitSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        unitSeparatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputsContainerView.addSubview(expirySeparatorView)
        expirySeparatorView.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor, constant: -130).isActive = true
        expirySeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        expirySeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        expirySeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(expiryDateTextField)
        expiryDateTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        expiryDateTextField.bottomAnchor.constraint(equalTo: expirySeparatorView.topAnchor).isActive = true
        expiryDateTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/3).isActive = true
        expiryDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputsContainerView.addSubview(categoryTextField)
        categoryTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        categoryTextField.topAnchor.constraint(equalTo: expirySeparatorView.bottomAnchor, constant: 30).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryTextField.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        inputsContainerView.addSubview(categorySeparatorView)
        categorySeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 8).isActive = true
        categorySeparatorView.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor).isActive = true
        categorySeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        categorySeparatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numOfRows: Int?
        if pickerView == unitPicker {
            numOfRows = units.count
        } else if pickerView == catPicker {
            numOfRows = categories.count
        }
        return numOfRows!
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var titleToReturn: String?
        if pickerView == unitPicker {
            titleToReturn = units[row]
        } else if pickerView == catPicker {
            titleToReturn = categories[row]
        }
        return titleToReturn
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == unitPicker {
            unitTextField.text = units[row]
        } else if pickerView == catPicker {
            categoryTextField.text = categories[row]
        }
    }
}

