//
//  Universidades.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

struct Universidade{
    
    var name: String?
    var universitySimbol: UIImage?
    var description: String?
    var semester: [Subjects] = []
    
    init(name: String?, universitySimbol: UIImage?, description: String?, semester: [Subjects])
    {
        self.name = name
        self.universitySimbol = universitySimbol
        self.description = description
        self.semester = semester
        
    }
    
}