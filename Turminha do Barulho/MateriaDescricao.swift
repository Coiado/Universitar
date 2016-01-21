//
//  MateriaDescricao.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 05/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse


struct MateriaDescricao {
    
    var curso: String?
    var universidades: [String]?
    var descricao: String?
    var file: PFFile
    
    
    init(curso: String?, universidades: [String]?, descricao: String?,file: PFFile){
        
        
        self.curso = curso
        self.universidades = universidades
        self.descricao = descricao
        self.file = file
        
    }
    
}