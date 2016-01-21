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
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    var id: String?
    var usuario : String?
    var usuarioId : String?
    @IBOutlet weak var answerDate: UILabel!
    
    
    //Numero maximo de caracteres para inserir o "veja mais"
    var maximumCharacterNumber = 300
    var isTextTooBig: Bool!
    var fullAnswer : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Checa o numero de caracteres e formata o texto se for necessario
    func formatText()
    {
        //Salvamos o texto inteiro
        self.fullAnswer = self.answerText.text
        
        //Contamos se o numero de caracteres é maior que o nosso maximo
        if(self.answerText.text?.characters.count > self.maximumCharacterNumber)
        {
            var firstString: String = ""
            
            //Formatamos a String
            for i in 0...150
            {
                let index = self.answerText.text?.startIndex.advancedBy(i)
                let char = self.answerText.text![index!]
                firstString.append(char)
            }
            
            firstString = firstString + "...\n(Clique para ver mais)"
            
            let noticeColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
            
            let atrString : NSMutableAttributedString = NSMutableAttributedString(string: firstString)
            atrString.addAttribute(NSForegroundColorAttributeName, value: noticeColor, range: NSRange(location: 154, length: 23))
            
            self.answerText.text = firstString
            self.answerText.attributedText = atrString
            self.isTextTooBig = true
        }
    }
    
    //Checa se clicamos no label
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //Checamos se eh necessario checar o toque
        if(self.isTextTooBig == true)
        {
            let touch : UITouch = touches.first!
            let touchPoint : CGPoint = touch.locationInView(self)
           
            //Checamos se nosso toque se encontra no retangulo da label
            if(self.answerText.frame.contains(touchPoint))
            {
                print("VER MAIS")
                //TO DO
                //Inserir metodo para mostrar o resto do texto, para isso usar a string fullAnswer
            }
        
        }
        
    }
    
    func cardSetup(){
        
        self.answerView.layer.masksToBounds = false
        self.answerView.layer.cornerRadius = 1
        self.answerView.layer.shadowOffset = CGSizeMake(1, 1) //??
        self.answerView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.answerView.bounds)
        self.answerView.layer.shadowPath = path.CGPath
        self.answerView.layer.shadowOpacity = 1
        self.userIcon.layer.masksToBounds = true
        self.userIcon.layer.cornerRadius = self.userIcon.frame.height/2
        
    }
    @IBAction func UpVote(sender: AnyObject) {

        if !liked{
            
            ParseModel.aumentarLikeComentario(self.id!, completionHandler: { (sucesso, error) -> Void in
                if error == nil{
                    ParseModel.salvarNovoLike(self.id!, usuario: self.usuarioId!, completionHandler: { (sucesso, error) -> Void in
                        if error == nil{
                            print("foi")
                        }
                    })
                }
            })

            
//            ParseModel.diminuirLikeComentario(self.id!, completionHandler: { (sucesso, error) -> Void in
//                if error == nil {
//                    ParseModel.apagarLike(self.id!, completionHandler: { (sucesso, error) -> Void in
//                        //FAZER ALGO
//                    })
//                }
//            })
            
            var like = Int(self.likes.text!)! as Int
            like = like+1
            self.likes.text = String(like)
            liked = true
            //self.likeButton.backgroundColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        }
        else{
            
            var like = Int(self.likes.text!)! as Int
            like = like-1
            self.likes.text = String(like)
            liked = false
            //self.likeButton.backgroundColor = UIColor.clearColor()
            
        }
        
        
    }
    @IBAction func DownVote(sender: AnyObject) {

        
//        ParseModel.findDenuncia(self.id!) { (object, error) -> Void in
//            
//            if error == nil {
//                
//                ParseModel.aumentarDenuncia(object!, completionHandler: { (sucesso, error) -> Void in
//                    
//                    if error == nil {
//                        //fazer algo
//                    }
//                    
//                })
//                
//            }
//            else{
//                
//                ParseModel.criarDenuncia(self.id!, completionHandler: { (sucesso, error) -> Void in
//                    
//                    //fazer algo
//                    
//                })
//                
//            }
//            
//        }
        
        
        
        if !disliked{
            var like = Int(self.likes.text!)! as Int
            like = like - 1
            self.likes.text = String(like)
            disliked = true
            //self.dislikeButton.backgroundColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        }
        else{
            
            var like = Int(self.likes.text!)! as Int
            like = like + 1
            self.likes.text = String(like)
            disliked = false
            //self.dislikeButton.backgroundColor = UIColor.clearColor()
            
        }
    
    }

}
