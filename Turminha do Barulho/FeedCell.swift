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
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var upvoteCount: UILabel!
    
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var fullText: String!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cardSetup(){
        
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.cornerRadius = 1
        self.cardView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.cardView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.cardView.bounds)
        self.cardView.layer.shadowPath = path.CGPath
        self.cardView.layer.shadowOpacity = 1
        
        self.textField.editable = false
        
        
    }
    
    
    
}
