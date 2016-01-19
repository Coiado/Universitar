//
//  DetalhesNoticiaCell.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 27/11/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class NewsDetailCell: UITableViewCell {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var categoriaTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var fullText: UILabel!
    @IBOutlet weak var upVoteButton: UIButton!
    var isVoted: Bool!
    
    //Atributos do quadrado branco
    let squareOrigin : CGPoint = CGPoint(x: -10, y: -10)
    
    //let charNumber = (self.categoriaTitle.text?.characters.count)!*8
    let squareSize : CGSize = CGSize(width: 240, height: 40)

    func prepareCell()
    {
        
        //Quadrado branco com! a label da noticia
        let whiteSquare : UIView = UIView(frame: CGRect(origin: squareOrigin, size: squareSize))
        
        whiteSquare.layer.cornerRadius = 10
        whiteSquare.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        whiteSquare.alpha = 0.8
        self.imagem.addSubview(whiteSquare)
        self.bringSubviewToFront(self.subTitle)
        
        self.subTitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.updateButton()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Nao queremos que a celula seja selecionavel
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    
    func updateButton()
    {
        if((self.isVoted) != nil)
        {
            if(self.isVoted == false)
            {
                self.upVoteButton.setTitle("☆", forState: .Normal)
                self.isVoted = false
            }
            else
            {
                self.upVoteButton.setTitle("★", forState: .Normal)
                self.isVoted = true
            }
        }
        
    }
    
    @IBAction func upVote(sender: AnyObject) {
        
        self.updateButton()
        
        //INSERIR METODOS DO PARSE
        
    }
    

}
