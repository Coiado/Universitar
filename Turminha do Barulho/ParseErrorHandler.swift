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
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Não foi possivel estabelecer conexão.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
        
            //incorrect password ou object not found
        case 101:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "A senha está errada.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            //internal error
        case 1:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Tente novamente", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            // timeout
        case 124:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "O tempo limite para conexão foi atingido.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            // invalid email
        case 125:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "E-mail inválido.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            // exceed quota
        case 140:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Tente novamente.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            // username missing
        case 200:
            
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Preencha o campo de usuário.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            
            break
            
            //password missing
        case 201:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Preencha o campo de senha.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            //username taken
        case 202:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "O usuário já existe.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            
            //email taken
        case 203:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "O e-mail já foi cadastrado.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            //email missing
        case 204:
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Preencha o campo de e-mail", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
            //default
            
        default:
            
            let alert = UIAlertController(title: "Um erro ocorreu", message: "Por favor, tente novamente.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
            })
            
            alert.addAction(action)
            return alert
            break
            
        }
        
    }
    
    
}