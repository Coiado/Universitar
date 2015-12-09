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
    
    //Atributos do quadrado branco
    let squareOrigin : CGPoint = CGPoint(x: 0, y: 0)
    let squareSize : CGSize = CGSize(width: 120, height: 30)

    func prepareCell()
    {
        let whiteSquare : UIView = UIView(frame: CGRect(origin: squareOrigin, size: squareSize))
        whiteSquare.backgroundColor = UIColor.whiteColor()
        whiteSquare.alpha = 0.8
        self.imagem.addSubview(whiteSquare)
        
        self.bringSubviewToFront(self.subTitle)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
