//
//  LoginController.swift
//  FreshList
//
//  Created by Abhinav Kumar on 10/21/18.
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    // BEGIN Configuration of UI elements for login screen: Logo, login/register toggle, input fields, login/register button
    // Configure Logo
    let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "icons8-organic-food-480")
        logo.contentMode = .scaleAspectFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
    }()
    // Configure container for input fields
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 128, g: 171, b: 103)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    // Configure name field
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 230, g: 230, b: 230)])
        tf.translatesAutoresizingMaskIntoConstraints = false
       
        return tf
    }()
    // Configure line under name field
    let nameSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.white
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    // Configure email field
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 230, g: 230, b: 230)])
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    // Configure line under name field
    let emailSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.white
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    // Configure password field
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        var pw = tf.text
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(r: 230, g: 230, b: 230)])
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    // Configure line under password field
    let passwordSeparatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.white
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }()
    // Configure login/register button
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(r: 48,g: 89, b: 23), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
         button.addTarget(self, action: #selector(login_button_pressed), for: .touchUpInside)
        return button
    }()
    
    // Configure skip login button
    let skipLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Skip For Now", for: .normal)
        button.setTitleColor(UIColor(r: 230, g: 230, b: 230), for: .normal)
        button.addTarget(self, action: #selector(handleSkipLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Function called to skip login and go to home screen
    @objc func handleSkipLogin() {
        let tabBarController = CustomTabBarController()
        present(tabBarController, animated: true, completion: nil)
        
    }
    @objc func login_button_pressed () {
        
        if loginRegisterButton.currentTitle == "Register" {
            print("register button pressed")
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
                // ...
//                guard let user = authResult?.user else {  return  }

                if ((error) != nil) {
                    let alertController = UIAlertController(title: "Error Registering account !", message:
                        "\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default,handler: { action in
                        //run your function here
                        let stayBarController = LoginController()
                        self.present(stayBarController, animated: false, completion: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                else  {
                    
                    let alertController = UIAlertController(title: "Thank you for Signing Up!", message:
                        "Please login to continue!", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default,handler: { action in
                        //run your function here
                        let loginBarController = LoginController()
                        self.present(loginBarController, animated: true, completion: nil)
                        
                        print("loginBarController called")
                        
                        
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        else {
            print("loging button pressed")
            
            Auth.auth().signIn(withEmail:  emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                
                if ((error) != nil) {
                    let alertController = UIAlertController(title: "Error Logging into account !", message:
                        "\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default,handler: { action in
                        //run your function here
//                        let errorloginBarController = LoginController()
//                        self.present(errorloginBarController, animated: false, completion: nil)
//
//                        print("errorloginBarController called")
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                else  {
                    
                    let alertController = UIAlertController(title: "Welcome!", message:
                        "to freshlists!", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default,handler: { action in
                        //run your function here
                        let loginBarController = CustomTabBarController()
                        self.present(loginBarController, animated: true, completion: nil)
                        
                        print("loginBarController called")
            
                        
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
                // ...
            }

        }
        
        
        
        
        
    }
    
    // Confiure login/register toggle
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let segctrl = UISegmentedControl(items: ["Login","Register"])
        segctrl.layer.cornerRadius = 25
        segctrl.tintColor = UIColor(r: 48,g: 89, b: 23)
        segctrl.selectedSegmentIndex = 1
        segctrl.addTarget(self, action: #selector(handleLoginRegisterToggle), for: .valueChanged)
        segctrl.translatesAutoresizingMaskIntoConstraints = false
        
        return segctrl
    }()
    
    
    // Function called by toggle to configure view appropriately
    @objc func handleLoginRegisterToggle() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: (loginRegisterSegmentedControl.selectedSegmentIndex))
        loginRegisterButton.setTitle(title, for: .normal)
        //Adjust height of inputsContainerView
        inputsContainerViewHeightAnchorConstraint?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        // Remove or add Name field based on Login/Register toggle
        nameTextFieldHeightAnchorConstraint?.isActive = false
        nameTextFieldHeightAnchorConstraint = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,
                                                                                    multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchorConstraint?.isActive = true
        // Even out spacing of Email Address and Password fields based on Login/Register Toggle, "remove" nameSeparator line
        emailTextFieldHeightAnchorConstraint?.isActive = false
        emailTextFieldHeightAnchorConstraint = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,
                                                                                    multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchorConstraint?.isActive = true

        passwordTextFieldHeightAnchorConstraint?.isActive = false
        passwordTextFieldHeightAnchorConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,
                                                                                      multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchorConstraint?.isActive = true
        
        nameSeparatorViewHeightAnchorConstraint?.isActive = false
        nameSeparatorViewHeightAnchorConstraint = nameSeparatorView.heightAnchor.constraint(equalToConstant: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1)
        nameSeparatorViewHeightAnchorConstraint?.isActive = true
    }
    // END Configuration of UI elements for login screen: Logo, login/register toggle, input fields, login/register button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(logoImageView)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(skipLoginButton)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupLogoImageView()
        setupLoginRegisterSegmentedControl()
        setupSkipLoginButton()
        
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(r: 128, g: 171, b: 103)
    }
    
    // Function to set up boundaries and positioning for login/register toggle
    private func setupLoginRegisterSegmentedControl() {
        // Set up X, Y, width, and height constraints for Login/Register segmented control
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // Function to set up boundaries and positioning for logo
    private func setupLogoImageView() {
        // Set up X, Y, width, and height constraints for logo
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // Variables to hold height constraints for input fields for modification by login/register toggle
    private var inputsContainerViewHeightAnchorConstraint: NSLayoutConstraint?
    private var nameTextFieldHeightAnchorConstraint: NSLayoutConstraint?
    private var nameSeparatorViewHeightAnchorConstraint: NSLayoutConstraint?
    private var emailTextFieldHeightAnchorConstraint: NSLayoutConstraint?
    private var passwordTextFieldHeightAnchorConstraint: NSLayoutConstraint?
    
    // Function to set up bounds and positioning for input container and fields in view
    private func setupInputsContainerView() {
        // Set up X, Y, width, and height constraints for inputs
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchorConstraint = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchorConstraint?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        // Set up X, Y, width, and height constraints for name field
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchorConstraint = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchorConstraint?.isActive = true
        
        inputsContainerView.addSubview(nameSeparatorView)
        // Set up X, Y, width, and height constraints for line under name field
        nameSeparatorView.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -12).isActive = true
        nameSeparatorViewHeightAnchorConstraint = nameSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        nameSeparatorViewHeightAnchorConstraint?.isActive = true
        
        inputsContainerView.addSubview(emailTextField)
        // Set up X, Y, width, and height constraints for email field
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchorConstraint = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchorConstraint?.isActive = true
        
        inputsContainerView.addSubview(emailSeparatorView)
        // Set up X, Y, width, and height constraints for line under email field
        emailSeparatorView.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -12).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(passwordTextField)
        // Set up X, Y, width, and height constraints for password field
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchorConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchorConstraint?.isActive = true
        
        inputsContainerView.addSubview(passwordSeparatorView)
        // Set up X, Y, width, and height constraints for line under email field
        passwordSeparatorView.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -1).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -12).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    // Function to set up boundaries and positioning for login/register button
    private func setupLoginRegisterButton() {
        // Set up X, Y, width, and height constraints for login/register button
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // Function to set up boundaries and positioning for skip login button
    private func setupSkipLoginButton() {
        // Set up X, Y, width, and height constraints for skip login button
        skipLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipLoginButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 30).isActive = true
    }
    
}

