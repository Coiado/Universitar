//
//  AnswerDetailTableViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 21/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var passedCell:AnswerTableViewCell?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .None
    }
    
    //TABLEVIEW METHODS
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AnswerCell",forIndexPath: indexPath) as! AnswerTableViewCell

        cell.usuario = passedCell?.usuario
        cell.usuarioId = passedCell?.usuarioId
        
        cell.answerDate.text = passedCell?.answerDate.text
        
        cell.userIcon.image = passedCell?.userIcon.image
        
        cell.userIcon.layer.masksToBounds = true
        cell.userIcon.layer.cornerRadius = 15
        cell.nickName.text = passedCell?.nickName.text
        cell.nickName.font = UIFont(name: "Futura", size: 13.0)
        cell.answerText.text = passedCell?.fullAnswer
        cell.answerText.font = UIFont(name: "Futura", size: 14.0)
        cell.answerText.sizeToFit()
        cell.updateConstraints()
        //cell.cardSetup()
        return cell

        
    }
    @IBAction func denunciaComentario(sender: AnyObject) {
        
        let id = self.passedCell?.id
            
        self.activityIndicator.startAnimating()
        
        if let user = PFUser.currentUser(){
            
            ParseModel.findDenuncia(id!) { (object, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                
                if error == nil{
                    
                    let alert = UIAlertController(title: "Denúncia", message: "Você já denunciou esse comentário, vamos analisar, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                    })
                    
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                    
                else {
                    
                    let alert = UIAlertController(title: "Denúncia", message: "Fale o motivo da denúncia que vamos analisar, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    var titleTextField: UITextField?
                    alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
                        titleTextField = textField
                        textField.placeholder = "Motivo"
                    }
                    
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
                    
                    alert.addAction(cancelAction)
                    
                    let action = UIAlertAction(title: "Enviar", style: .Default, handler: { (UIAlertAction) -> Void in
                        
                        if let text = titleTextField?.text{
                            ParseModel.criarDenuncia(id!,motivo: text, completionHandler: { (sucesso, error) -> Void in
                                
                                if error == nil {
                                    
                                    self.denunciaFeita()
                                }
                                
                            })
                        }
                    })
                    
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
            }
        }
        else{
            
            self.activityIndicator.stopAnimating()
            
            let alert = UIAlertController(title: "Denúncia", message: "Para seguir essa ação por favor fazer login, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Login", style: .Default, handler: { (UIAlertAction) -> Void in
            
                let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
                self.presentViewController(vc, animated: true, completion: { () -> Void in
                    
                    
                })
            
            })
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .Default, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func denunciaFeita(){
        
        let alertController = UIAlertController(title: "Denúncia realiza", message: "Obrigado, sua denúncia foi realizada com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
