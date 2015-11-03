//
//  AnswerTableViewCell.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/1/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var answerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cardSetup(){
        
        self.answerView.layer.masksToBounds = false
        self.answerView.layer.cornerRadius = 1
        self.answerView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.answerView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.answerView.bounds)
        self.answerView.layer.shadowPath = path.CGPath
        self.answerView.layer.shadowOpacity = 1
        
        
    }

}
