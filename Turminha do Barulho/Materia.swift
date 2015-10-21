//
//  Materia.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/20/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

struct Materia {
    var name: String?
    var color: UIColor?
    var icon: UIImage?
    
    init(name: String?, color: UIColor?, icon: UIImage?) {
        self.name = name
        self.color = color
        self.icon = icon
    }
}