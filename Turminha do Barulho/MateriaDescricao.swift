//
//  MateriaDescricao.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 05/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit


struct MateriaDescricao {
    
    var curso: String?
    var universidades: [String]?
    var descricao: String?
    
    
    init(curso: String?, universidades: [String]?, descricao: String?){
        
        
        self.curso = curso
        self.universidades = universidades
        self.descricao = descricao
        
    }
    
}