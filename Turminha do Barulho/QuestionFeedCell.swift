//
//  QuestionFeedCell.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

protocol QuestionFeedCellDelegate: class {
    func didClickDenunciaButtonForCell(cell: QuestionFeedCell)
}

class QuestionFeedCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var perguntaTitulo: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var denunciaButton: UIButton!
    var answers : [Answer] = []
    weak var delegate: QuestionFeedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cardSetup(){
        
        //QUESTION VIEW
        self.questionView.layer.masksToBounds = true
        self.questionView.layer.cornerRadius = 0
        self.questionView.backgroundColor = UIColor(red: 90/255, green: 107/255, blue: 117/255, alpha: 1)
        
        //CONTENT VIEW
        self.contentView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        //USER ICON
        self.userIcon.layer.masksToBounds = true
        self.userIcon.layer.cornerRadius = self.userIcon.frame.height/2
        
        //WHITE CIRCLE
        let whiteCircleOrigin = self.userIcon.frame.origin
        let whiteCircleSize = self.userIcon.frame.size
        
        let whiteCircle = UIView(frame: CGRect(origin: whiteCircleOrigin, size: whiteCircleSize))
        whiteCircle.backgroundColor = UIColor.whiteColor()
        whiteCircle.layer.cornerRadius = self.userIcon.frame.height/2
        
        self.questionView.addSubview(whiteCircle)
        self.questionView.sendSubviewToBack(whiteCircle)
        
        //BLUE SQUARE
        let blueSquareOrigin = CGPoint(x: 0, y: 0)
        let blueSquareSize = CGSize(width: 60, height: self.questionView.frame.height)
        
        let blueSquare = UIView(frame: CGRect(origin: blueSquareOrigin, size: blueSquareSize))
        blueSquare.backgroundColor = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1)
        blueSquare.layer.cornerRadius = 0

        self.questionView.addSubview(blueSquare)
        self.questionView.sendSubviewToBack(blueSquare)
        
        //RED SQUARE
        let redSquareOrigin = CGPoint(x: 0, y: 0)
        let redSquareSize = CGSize(width: self.questionView.frame.width+100, height: 20)
        
        let redSquare = UIView(frame: CGRect(origin:redSquareOrigin, size: redSquareSize))
        redSquare.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
        
        self.questionView.addSubview(redSquare)
        self.questionView.sendSubviewToBack(redSquare)
        
        //Text Color and Font
        self.nickName.textColor = UIColor(red: 238/255, green: 171/255, blue: 32/255, alpha: 1)
        
        self.perguntaTitulo.textColor = UIColor.whiteColor()
        self.questionText.textColor = UIColor.whiteColor()
        self.dateLabel.textColor = UIColor.whiteColor()
        self.nickName.sizeToFit()

    }
    
    @IBAction func denunciaButtonClicked(sender: UIButton) {
        delegate?.didClickDenunciaButtonForCell(self)
    }
    
}
