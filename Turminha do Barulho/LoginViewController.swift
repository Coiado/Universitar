//
//  LoginViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import ParseUI


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var navigationLogin: UINavigationItem!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tabBar : UITabBarController?
    let permissions = ["public_profile"]
    
    override func viewDidLoad() {
    
        
        if PFUser.currentUser() != nil{
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.performSegueWithIdentifier("config", sender: self)
            })
            
            
            print("teste")
        }
        self.navigationLogin.title = "Login"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0) ]
        self.activityIndicator.hidesWhenStopped = true
        
        configureButton()
        
        
        
    }
    
    
    
    func configureButton() {
        
        self.loginButton.addTarget(self, action: "loginAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginFacebook.layer.cornerRadius = 5
//        self.loginButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
//        self.loginButton.layer.cornerRadius = 5
        
        self.signupButton.addTarget(self, action: "signupAction", forControlEvents: UIControlEvents.TouchUpInside)
//        self.signupButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
//        self.signupButton.layer.cornerRadius = 5

        
        self.forgetButton.addTarget(self, action: "forgetAction", forControlEvents: UIControlEvents.TouchUpInside)
//        self.forgetButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
//        self.forgetButton.layer.cornerRadius = 5

        
        
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
                
                let alert = ParseErrorHandler.errorHandler((error?.code)!)
                
                self.presentViewController(alert, animated: true, completion: nil)

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
        
        let titlePrompt = UIAlertController(title: "Nova senha",
            message: "Entre o e-mail que você cadastrou:",
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "E-mail"
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "Resetar", style: .Default , handler: { (action) -> Void in
            if let textField = titleTextField {
                self.resetPassword(textField.text!)
            }
        }))
        
        self.presentViewController(titlePrompt, animated: true, completion: nil)

    }
    
    
    func resetPassword(email:String){
        
        // convert the email string to lower case
        let emailToLowerCase = email.lowercaseString
        // remove any whitespaces before and after the email address
        let emailClean = emailToLowerCase.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        PFUser.requestPasswordResetForEmailInBackground(emailClean) { (success, error) -> Void in
            if (error == nil) {
                let success = UIAlertController(title: "Successo", message: "Successo! Cheque seu e-mail!", preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                success.addAction(okButton)
                self.presentViewController(success, animated: false, completion: nil)
                
            }else {
                let errormessage = error!.userInfo["error"] as! NSString
                let error = UIAlertController(title: "Não foi possível renovar", message: errormessage as String, preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                error.addAction(okButton)
                self.presentViewController(error, animated: false, completion: nil)
            }
        }
        
    }

    
    @IBAction func signInFacebook(sender: AnyObject) {
    
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"], block: {(user:PFUser?, error:NSError?) -> Void in
        
            if(error != nil) {
            // Display alert to warn the user of the error that happened
                let myAlert = UIAlertController(title:"",message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okClicked = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okClicked)
                self.presentViewController(myAlert,  animated: true, completion: nil)
            
                return
            
            }
            
            print(user)
            print("Token atual = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("ID do Usuario, do Face = \(FBSDKAccessToken.currentAccessToken().userID) ")
            
             //I can take the user to  protected page, since it isn't nil
            if (FBSDKAccessToken.currentAccessToken() != nil){
            
                let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("ProtectedProfilePage") as! ConfigViewController
                
                let protectedPageNavigator = UINavigationController(rootViewController: protectedPage)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = protectedPage
            
            }
            
        })
    
    }
    
}





