//
//  FeedCell.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var upvotes: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var fullText: String!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Seta o layout da carta
    func cardSetup(){
        
        
        //Atributo do retanguloBranco
        let rectOrigin: CGPoint = CGPoint(x:0, y:0)
        let rectSize : CGSize = CGSize(width: self.cardView.frame.width, height: 20)
        let whiteRect : UIView = UIView(frame: CGRect(origin: rectOrigin, size: rectSize))
        whiteRect.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
        whiteRect.alpha = 1
        self.cardView.addSubview(whiteRect)
        self.cardView.sendSubviewToBack(whiteRect)
    
        
        //Atributos do quadrado de curtidas
        let squareOrigin : CGPoint = CGPoint(x: 0, y: 0)
        let squareSize : CGSize = CGSize(width: self.picture.frame.width, height: 20)
        let blackSquare : UIView = UIView(frame: CGRect(origin: squareOrigin, size: squareSize))
        blackSquare.backgroundColor = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1)
        blackSquare.alpha = 1
        self.picture.addSubview(blackSquare)
        self.bringSubviewToFront(self.upvotes)
        self.bringSubviewToFront(self.picture)
        
        //Arredondamos a celula e a imagem da noticia
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.cornerRadius = 15
        self.cardView.clipsToBounds = true
        self.picture.layer.masksToBounds = true
        self.picture.layer.cornerRadius = 15
        
        //Alteramos o background da celula (nao da card view
        self.contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        //Alteramos o texto da tag para que haja contraste entre os textos
        self.title.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.subTitle.textColor = UIColor.whiteColor()
        self.title.backgroundColor = UIColor.clearColor()
        self.textField.textColor = UIColor.whiteColor()
        self.dateLabel.textColor = UIColor.whiteColor()
        
        self.cardView.backgroundColor = UIColor(red: 90/255, green: 107/255, blue: 117/255, alpha: 1)
        
    }
    
}
