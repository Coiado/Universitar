//
//  Notificacao.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 07/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import Parse
import UIKit

struct Notificacao {
    
    var usuario: String
    var para : String
    var imagem: PFFile?
    
    init(usuario:String, imagem: PFFile?, para: String){
        
        self.usuario = usuario
        self.imagem = imagem
        self.para = para
        
    }
    
    
    
}