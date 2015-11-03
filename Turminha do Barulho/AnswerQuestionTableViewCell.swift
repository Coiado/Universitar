//
//  AnswerQuestionTableViewCell.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/30/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerQuestionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var perguntaTitulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cardSetup(){
        
        self.questionView.layer.masksToBounds = false
        self.questionView.layer.cornerRadius = 1
        self.questionView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.questionView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.questionView.bounds)
        self.questionView.layer.shadowPath = path.CGPath
        self.questionView.layer.shadowOpacity = 1
        
        
    }

}