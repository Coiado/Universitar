//
//  userCell.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 07/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var userLabel: UILabel!

    @IBOutlet weak var userImageButton: UIButton!
    
    @IBOutlet weak var editarButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
