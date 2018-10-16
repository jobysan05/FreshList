//
//  LoginViewController.swift
//  Fresh List
//
//  Created by Abhinav Kumar on 10/15/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, signupDelegate {
    func addUserFunction(username: String, password: String) {
        loginInfoDictionary[username] = password
    }
    
    var username: String = ""
    var loginInfoDictionary = ["admin":"pass"]
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginForUser" {
            let segueUser = segue.destination as! IngredientsTableViewController
            segueUser.uName = username
        }
        if segue.identifier == "segueToSignUp"{
            let segueSignIn = segue.destination as! SignUpViewController
            segueSignIn.delegate = self
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if (username == "" || password == "") {
            let alert = UIAlertController(title: "Incorrect Username/Password!", message: "Please enter your login information correctly.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if password != loginInfoDictionary[username] {
            let alert = UIAlertController(title: "Incorrect Username/Password!", message: "Please enter your login information correctly.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if password == loginInfoDictionary[username] {
            // login successful
            performSegue(withIdentifier: "loggedInSegue", sender: self)
        }
        
    }
    
    @IBAction func registrationButton(_ sender: Any) {
        // perform segue to registration page
    }
    
}
