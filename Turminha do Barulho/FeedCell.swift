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
    @IBOutlet weak var upvoteCount: UILabel!
    
    var fullText: String!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setColors()
    {
        self.title.textColor = UIColor.redColor()
        self.cardView.backgroundColor = UIColor.blackColor()
       
    }

    func cardSetup(){
        
        
          self.cardView.layer.masksToBounds = false
        
        self.cardView.layer.cornerRadius = 15
       
        self.picture.layer.masksToBounds = true
        self.picture.layer.cornerRadius = 15
        
        self.contentView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        
        self.subTitle.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        
        //Desenhamos a "sombra" da celula
        
            /*
          self.cardView.layer.shadowOffset = CGSizeMake(1, 1) //??
          self.cardView.layer.shadowRadius = 1
          var path = UIBezierPath(rect: self.cardView.bounds)
        
          self.cardView.layer.shadowPath = path.CGPath
          self.cardView.layer.shadowOpacity = 1
            */
        


       
        
        
    }
    
}
