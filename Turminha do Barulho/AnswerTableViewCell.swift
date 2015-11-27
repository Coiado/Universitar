//
//  AnswerTableViewCell.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/1/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var likes: UILabel!
    var liked : Bool = false
    var disliked : Bool = false
    @IBOutlet weak var viewAnswer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cardSetup(){
        
        self.answerView.layer.masksToBounds = false
        self.answerView.layer.cornerRadius = 1
        self.answerView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.answerView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.answerView.bounds)
        self.answerView.layer.shadowPath = path.CGPath
        self.answerView.layer.shadowOpacity = 1
        
        
    }
    @IBAction func UpVote(sender: AnyObject) {
        if !disliked && !liked{
            var like = Int(self.likes.text!)! as Int
            like = like+1
            self.likes.text = String(like) as! String
            liked = true
        }
        else{
            if !disliked{
                var like = Int(self.likes.text!)! as Int
                like = like-1
                self.likes.text = String(like) as! String
                liked = false
            }
            else{
                var like = Int(self.likes.text!)! as Int
                like = like+2
                self.likes.text = String(like) as! String
                disliked = false
            }
        }
        
    }
    @IBAction func DownVote(sender: AnyObject) {
        if !disliked && !liked{
            var like = Int(self.likes.text!)! as Int
            like = like-1
            self.likes.text = String(like) as! String
            disliked = true
        }
        else{
            if !liked{
                var like = Int(self.likes.text!)! as Int
                like = like+1
                self.likes.text = String(like) as! String
                disliked = false
            }
            else{
                var like = Int(self.likes.text!)! as Int
                like = like-2
                self.likes.text = String(like) as! String
                liked = false
            }
            
        }
    }

}
