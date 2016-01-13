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
    
    
    
    var fullText: String!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Funcao temporaria usada para testes para o modo noturno, talvez nao precisemos dela
    func setColors()
    {
        self.title.textColor = UIColor.redColor()
        self.cardView.backgroundColor = UIColor.blackColor()
       
    }

    //Seta o layout da carta
    func cardSetup(){
        //Atributos do quadrado de curtidas
        let squareOrigin : CGPoint = CGPoint(x: 0, y: (self.picture.frame.height-18))
        let squareSize : CGSize = CGSize(width: self.picture.frame.width, height: 20)
        let blackSquare : UIView = UIView(frame: CGRect(origin: squareOrigin, size: squareSize))
        blackSquare.backgroundColor = UIColor.blackColor()
        blackSquare.alpha = 1
        self.picture.addSubview(blackSquare)
        self.bringSubviewToFront(self.upvotes)
        
        //Arredondamos a celula e a imagem da noticia
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.cornerRadius = 15
       
        self.picture.layer.masksToBounds = true
        self.picture.layer.cornerRadius = 15
        
        //Alteramos o background da celula (nao da card view)
        self.contentView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        
        //Alteramos o texto da tag para que haja contraste entre os textos
        self.subTitle.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        
        //Desenhamos a "sombra" da celula
        //Talvez nao a usemos mais, manterei aqui caso mudemos de ideia
        /*
        self.cardView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.cardView.layer.shadowRadius = 1
        var path = UIBezierPath(rect: self.cardView.bounds)
        self.cardView.layer.shadowPath = path.CGPath
        self.cardView.layer.shadowOpacity = 1
        */
        
    }
    
}
