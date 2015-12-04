//
//  QuestionFeedCell.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class QuestionFeedCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var perguntaTitulo: UILabel!
    var answers : [Answer] = []
    
    
        
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
        self.questionView.layer.cornerRadius = 15
        self.questionView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.questionView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.questionView.bounds)
        self.questionView.layer.shadowPath = path.CGPath
        self.questionView.layer.shadowOpacity = 1
        
        
    }

    
}
