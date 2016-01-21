//
//  ParseErrorHandler.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 18/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class ParseErrorHandler {
    
    static func errorHandler(errorCode: Int) -> UIAlertController{
        
        switch errorCode{
        
            //Conection failed
        case 100:
            print(errorCode)
            break
        
            //incorrect password ou object not found
        case 101:
            
            break
            //internal error
        case 1:
            
            break
            
            // timeout
        case 124:
            
            break
            
            // invalid email
        case 125:
            
            break
            
            // exceed quota
        case 140:
            
            break
            
            // username missing
        case 200:
            
            break
            
            //password missing
        case 201:
            
            break
            
            //username taken
        case 202:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "O usuário já existe", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            
            //email taken
        case 203:
            
            break
            
            //email missing
        case 204:
            
            break
            
            //default
            
        default:
            
            break
            
        }
     
        return UIAlertController()
        
    }
    
    
}