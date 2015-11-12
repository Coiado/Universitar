//
//  MateriaTableViewCell.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/27/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class MateriaTableViewCell: UITableViewCell {

    var descricao: String!
    var name: String!
    var Universidades: NSArray!
    var Semestres: NSArray!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
