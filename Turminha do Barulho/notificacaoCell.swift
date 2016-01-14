//
//  notificacaoCell.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 14/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class notificacaoCell : UITableViewCell {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImage.layer.cornerRadius = 24
        // Initialization code
    }
    
    
    
}
