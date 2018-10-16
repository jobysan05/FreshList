//
//  SignUpViewController.swift
//  Fresh List
//
//  Created by Abhinav Kumar on 10/15/18.
//  Copyright © 2018 Abhinav Kumar. All rights reserved.
//

import UIKit

protocol signupDelegate {
    func addUserFunction(username: String, password: String)
}

class SignUpViewController: UIViewController {
    var delegate: signupDelegate?
    
    var uName:String?
    var uPass:String?

    @IBOutlet weak var uNameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromSignUpToLoggedIn" {
            let segueUpToIn = segue.destination as! IngredientsTableViewController
            segueUpToIn.uName = uName!
            delegate?.addUserFunction(username: uName!, password: uPass!)
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if (uNameTextField.text?.count)! > 0 && (passTextField.text?.count)! > 0 && (confirmPassTextField.text?.count)! > 0 {
            if passTextField.text == confirmPassTextField.text {
                uName = self.uNameTextField.text!
                uPass = self.passTextField.text!
                self.confirmPassTextField.text = ""
                self.passTextField.text = ""
                self.uNameTextField.text = ""
                
                performSegue(withIdentifier: "segueFromSignUpToLoggedIn", sender: self)
            }
            /*else if () {
                // Check if username already exists
            } */
            else {
                let alert = UIAlertController(title: "Invalid Password", message: "Passwords must match!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in alert.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)
            }
        }else {
            let alert = UIAlertController(title: "Missing Entry", message: "Please fill in all fields to register.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
