//
//  ConfiguracoesViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class ConfigViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usuario: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
        
    }
    
    
    func getUser(){
        
        let user = PFUser.currentUser()?.objectId
        
        ParseModel.findUser(user!) { (object, error) -> Void in
            
            if error == nil{
                
                self.usuario = object
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func getNotification(){
    
        
        ParseModel.findAllNotifications { (sucesso, error) -> Void in
            
            
            
        }
        
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Perfil", forIndexPath: indexPath) as! userCell
        
        cell.userLabel.text = self.usuario?.nome
        
        cell.userLabel.textColor = UIColor.blackColor()
        
        cell.userImageButton.layer.cornerRadius = 24
        
        let userIcon = UIImage(named: "userIcon")
        
        cell.userImageButton.tintColor = UIColor.clearColor()

        cell.userImageButton.setBackgroundImage(userIcon, forState: .Normal)
        
        self.usuario?.foto?.getDataInBackgroundWithBlock({ (foto, error) -> Void in
            if foto != nil{
                
                let image = UIImage(data: foto!)
                
                cell.userImageButton.setBackgroundImage(image, forState: .Normal)
            }
        })
        
        
        return cell
        
    }
    
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    
}



