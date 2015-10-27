//
//  UniversidadeTableViewCell.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/23/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class UniversidadeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var UniversidadeNome: UILabel!
    @IBOutlet weak var UniversidadeIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
