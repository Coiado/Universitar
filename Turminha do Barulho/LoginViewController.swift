//
//  LoginViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var forgetButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
    
        
        if PFUser.currentUser() != nil{
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.performSegueWithIdentifier("config", sender: self)
            })
            
            
            print("teste")
        }
        
        self.activityIndicator.hidesWhenStopped = true
        
        configureButton()
        
        
    }
    
    func configureButton() {
        
        self.loginButton.addTarget(self, action: "loginAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.signupButton.addTarget(self, action: "signupAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.forgetButton.addTarget(self, action: "forgetAction", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    func loginAction(){
        
        let username = self.loginTextField.text!
        let password = self.passwordTextField.text!
        
        self.activityIndicator.startAnimating()
        
        PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                    
            self.activityIndicator.stopAnimating()
            
            if ((user) != nil){
            
            self.performSegueWithIdentifier("config", sender: self)
            
            }
            else {
                print("ERRO LOGIN")
            }
        })
        
        
    }
    
    func signupAction(){
        
        performSegueWithIdentifier("CriarConta", sender: self)
        
    }
    
    
    func forgetAction(){
        
        //cuidar disso depois
        
    }
    
}





