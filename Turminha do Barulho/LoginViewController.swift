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
    @IBOutlet weak var navigationLogin: UINavigationItem!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tabBar : UITabBarController?
    
    override func viewDidLoad() {
    
        
//        if PFUser.currentUser() != nil{
//            
//            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                self.performSegueWithIdentifier("config", sender: self)
//            })
//            
//            
//            print("teste")
//        }
        self.navigationLogin.title = "Login"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0) ]
        self.activityIndicator.hidesWhenStopped = true
        
        configureButton()
        
        
    }
    
    func configureButton() {
        
        self.loginButton.addTarget(self, action: "loginAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
        self.loginButton.layer.cornerRadius = 5
        
        self.signupButton.addTarget(self, action: "signupAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.signupButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
        self.signupButton.layer.cornerRadius = 5

        
        self.forgetButton.addTarget(self, action: "forgetAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.forgetButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
        self.forgetButton.layer.cornerRadius = 5

        
        
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
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            }
            else {
                print("ERRO LOGIN")
            }
        })
        
        
    }
    
    func signupAction(){
        
        performSegueWithIdentifier("CriarConta", sender: self)
        
    }
    
    @IBAction func voltarParaTela(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func forgetAction(){
        
        //cuidar disso depois
        
    }
    
}





