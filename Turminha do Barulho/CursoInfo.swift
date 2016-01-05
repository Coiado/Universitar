//
//  CursoInfo.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 05/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit

struct CursoInfo {
    
    var curso: String?
    var descricaoUniversidade: String?
    var universidade: String?
    var semestres: [[String]]?
    
    init(curso: String?, universidade: String?,descricaoUniversidade: String?, semestres: [[String]]?){
        
        self.descricaoUniversidade = descricaoUniversidade
        self.curso = curso
        self.universidade = universidade
        self.semestres = semestres
        
    }
    
}
