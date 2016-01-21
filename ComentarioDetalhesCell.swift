//
//  ComentarioDetalhesCell.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 16/12/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class ComentarioDetalhesCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    //Necessario para o controle do numero de likes
    var numberOfLikes: Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Nao queremos que a celula seja selecionavel
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        //Alteramos as cores dos botoes, fazemos isso aqui para que o storyboard seja mais visivel
//        self.likeCount.backgroundColor = UIColor.clearColor()
//        self.likeButton.backgroundColor = UIColor.clearColor()
        self.flagButton.backgroundColor = UIColor.clearColor()
        self.commentText.backgroundColor = UIColor.clearColor()
        self.userName.backgroundColor = UIColor.clearColor()
        self.cardView.backgroundColor = UIColor.whiteColor()
        
        //Alteramos o corner radius da foto do usuario
        self.userImage.layer.cornerRadius = self.userImage.frame.width/2

        //Alteramos o background da celula (nao da card view)
        self.contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
    }
    
    //Formata a string de likes, basicamente colocando na forma: X likes

    
    //Setup inicial da celula
    func cellSetup()
    {
        self.commentText.sizeToFit()
    }


    
    //METODO DE FLAG(DENUNCIA)
    @IBAction func pressFlag(sender: AnyObject) {
    }
    
}
