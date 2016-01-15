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
    
    func saveImage(){
        
//        let imageData = UIImagePNGRepresentation(self.profilePic.image)
//        
//        let image = UIImage(data: imageData)
//        
//        let compressedImage = compressImage(image!)
//        
//        let picture = PFFile(name: "image.png", data: compressedImage)
//        
//        PFUser.currentUser()!["foto"] = picture
//        
//        PFUser.currentUser()!.saveInBackgroundWithBlock {
//            (success: Bool, error: NSError?) -> Void in
//            if (success) {
//                print("image has been saved")
//            } else {
//                print("image failed")
//            }
//        }
        
        
    }
    
    func compressImage(image:UIImage) -> NSData {
        // Reducing file size to a 10th
        
        var actualHeight : CGFloat = image.size.height
        var actualWidth : CGFloat = image.size.width
        let maxHeight : CGFloat = 1136.0
        let maxWidth : CGFloat = 640.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        let compressionQuality : CGFloat = 0.5
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
        UIGraphicsBeginImageContext(rect.size);
        image.drawInRect(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        let imageData = UIImageJPEGRepresentation(img, compressionQuality);
        UIGraphicsEndImageContext();
        
        return imageData!;
    }
    
}



