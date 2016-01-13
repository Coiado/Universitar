//
//  CriarContaViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class CriarContaViewController : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nomeTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheck: UIImageView!
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var usuarioCheck: UIImageView!
    
    @IBOutlet weak var confirmationTextField: UITextField!
    @IBOutlet weak var confirmationCheck: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailCheck: UIImageView!
    
    @IBOutlet weak var confirmaButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        configureButton()
        
        self.activityIndicator.hidesWhenStopped = true
        
    }

    func configureButton(){
        
        self.confirmaButton.addTarget(self, action: "confirmaAction", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nomeTextField.resignFirstResponder()
        self.usuarioTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.confirmationTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func confirmaAction(){
        
        let nome = nomeTextField.text!
        let usuario = usuarioTextField.text!
        let senha = passwordTextField.text!
        let confirmacao = confirmationTextField.text!
        let email = emailTextField.text!
        
        self.activityIndicator.startAnimating()
        let user = PFUser()
        user["nome"] = nome
        user.username = usuario
        user.password = senha
        user.email = email
        if confirmacao == senha{
            user.signUpInBackgroundWithBlock { (Bool, ErrorType) -> Void in
                
                self.activityIndicator.stopAnimating()
                
                if ErrorType == nil{
                    self.performSegueWithIdentifier("config", sender: self)
                }
                else{
                    print("ERROR CADASTRO")
                }
            
            }
        }
    }
    
    
}









