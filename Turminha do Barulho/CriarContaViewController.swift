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
    
    @IBOutlet weak var navigationCadastro: UINavigationItem!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheck: UIImageView!
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var usuarioCheck: UIImageView!
    
    @IBOutlet weak var confirmationTextField: UITextField!
    @IBOutlet weak var confirmationCheck: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailCheck: UIImageView!
    
    @IBOutlet weak var nomeCheck: UIImageView!
    
    @IBOutlet weak var confirmaButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var senha : String = String()
    
    var keyboardUp : Bool = false
    
    override func viewDidLoad() {
        
        configureButton()
        
        self.navigationCadastro.title = "Cadastro"
        
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.confirmaButton.layer.cornerRadius = 5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        
    }

    func configureButton(){
        
        self.confirmaButton.addTarget(self, action: "confirmaAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.confirmaButton.enabled = false
//        self.confirmaButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
//        self.confirmaButton.layer.cornerRadius = 5
        
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
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else{
                    let alert = ParseErrorHandler.errorHandler((ErrorType?.code)!)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            
            }
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if (keyboardUp == false){
            self.view.frame.origin.y -= 145
            keyboardUp = true
        }
    }
    func keyboardWillHide(sender: NSNotification) {
        if (keyboardUp){
            self.view.frame.origin.y += 145
            keyboardUp = false
        }
        
    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        
        
        let tag = textFieldTag.init(rawValue: textField.tag)!
        
        let check = UIImage(named: "checkIcon")
        
        let uncheck = UIImage(named: "uncheckIcon")
        
        
        
        switch tag {
            
        case textFieldTag.nome:
            
            if textField.text != "" {
                
                self.nomeCheck.image = check
            }
            else{
                
                self.nomeCheck.image = uncheck
                
            }
            
            break
        case textFieldTag.usuario:
            if textField.text == "" {
                
                self.usuarioCheck.image = uncheck
            }

            else{
                
                let query = PFUser.query()
                
                let username = textField.text!
                
                query?.whereKey("username", equalTo: username)
                
                query?.countObjectsInBackgroundWithBlock({ (count, error) -> Void in
                    
                    if count > 0 {
                        
                        self.usuarioCheck.image = uncheck
                        
                        let alert = UIAlertController(title: "Erro", message: "Esse usuário já existe.", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                        })
                        
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                    else{
                        
                        self.usuarioCheck.image = check
                        
                    }
                })
                
            }
            break
        case textFieldTag.senha:
            
            if textField.text != "" {
                self.senha = textField.text!
                self.passwordCheck.image = check
            }
            else{
                
                self.passwordCheck.image = uncheck
                
            }
            
            break
        case textFieldTag.confirmacao:
            print("confirmaca")
            
            if textField.text == senha && textField.text != ""{
                
                self.confirmationCheck.image = check
            }
            else{
                
                self.confirmationCheck.image = uncheck
                
                let alert = UIAlertController(title: "Error", message: "As senhas não coincidem, tente novamente.", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                })
                
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            break
        case textFieldTag.email:
            
            if textField.text == "" {
                
                self.emailCheck.image = uncheck
            }
                
            else{
                
                let query = PFUser.query()
                
                let username = textField.text!
                
                query?.whereKey("email", equalTo: username)
                
                query?.countObjectsInBackgroundWithBlock({ (count, error) -> Void in
                    
                    if count > 0 {
                        
                        self.emailCheck.image = uncheck
                        let alert = UIAlertController(title: "Erro", message: "Esse e-mail já foi cadastrado.", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                        })
                        
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                        
                    else{
                        
                        self.emailCheck.image = check
                        
                    }
                })
                
            }
            
            break
            
        }
        
        if (nomeCheck.image == check && usuarioCheck.image == check && emailCheck.image == check && passwordCheck.image == check && confirmationCheck.image == check){
            
            
            self.confirmaButton.enabled = true
            
        }
        
        
    }
    
    
}//classe

enum textFieldTag: Int {
    
    case nome = 1, usuario,senha,confirmacao,email
    
}








