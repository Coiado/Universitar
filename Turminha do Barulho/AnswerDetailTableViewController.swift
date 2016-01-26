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
        
        ParseModel.findDenuncia(id!) { (object, error) -> Void in
            
            if error == nil {
                
                
                ParseModel.aumentarDenuncia(object!, completionHandler: { (sucesso, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    if error == nil{
                        self.denunciaFeita()
                    }
                    else{
                        
                        let alert = ParseErrorHandler.errorHandler((error?.code)!)
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                })
            }else{
                
                ParseModel.criarDenuncia(id!, completionHandler: { (sucesso, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    if error == nil {
                        
                        self.denunciaFeita()
                        
                    }
                    else{
                        let alert = ParseErrorHandler.errorHandler((error?.code)!)
                        
                        self.presentViewController(alert, animated: true, completion: nil)

                    }
                    
                    
                })
                
            }
            
        }
        
    }
    
    func denunciaFeita(){
        
        let alertController = UIAlertController(title: "Denuncia realiza", message: "Obrigado, sua denuncia foi realizada com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
