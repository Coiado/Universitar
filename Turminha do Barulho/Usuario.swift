//
//  User.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 06/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

struct Usuario {
    
    var nome: String
    var foto: PFFile?
    var imagem: UIImage
    
    init(nome: String, foto: PFFile?){
        
        self.nome = nome
        self.foto = foto
        self.imagem = UIImage(named: "userIcon")!
        
    }
    
}

