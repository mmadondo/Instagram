//
//  LoginViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/27/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    let loginAlertController = UIAlertController(title: "Invalid Input", message: "Please enter username AND password", preferredStyle: .alert)
    
    let signInErrorAlert = UIAlertController(title: "Wrong credentials", message: "Please enter correct username/password", preferredStyle: .alert)
    
    //instantiate connections
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //hide keyboard
    }
    
    
    //when user signs in/ presses login button
    @IBAction func onLogin(_ sender: Any) {
        
        let username = usernameField.text ?? ""     //the user's username
        let password = passwordField.text ?? ""     //the user's password
        
        if username.isEmpty {
            
            //alert user
            self.present(self.signInErrorAlert, animated: true)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
                self.usernameField.text = nil
            }
            // add the OK action to the alert controller
            signInErrorAlert.addAction(OKAction)
            
        } else if password.isEmpty {
            
            self.present(self.signInErrorAlert, animated: true)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
                self.passwordField.text = nil
            }
            // add the OK action to the alert controller
            signInErrorAlert.addAction(OKAction)
            
        } else {
            
            /*
             Makes an asynchronous request to log in a user with specified credentials.
             *Returns an instance of the successfully logged in PFUser.
             *This also caches the user locally so that calls to PFUser.currentUser() will use the latest logged in user.
             *@param:  - username: The username of the user.
                       - password: The password of the user.
             */
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    
                    self.present(self.loginAlertController, animated: true)
                    print("User log in failed: \(error.localizedDescription)")
                    
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
            }
            
        }
        
        
        
    }
    
    //User can sign up to create a new account using Parse authentication
    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
    
        
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty{
            self.present(self.loginAlertController, animated: true)
            
        } else{
            // call sign up function on the object to sign up the user asynchronously and avoid duplicates
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
            self.usernameField.text = nil
            self.passwordField.text = nil
        }
        // add the OK action to the alert controller
        loginAlertController.addAction(OKAction)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
