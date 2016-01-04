//
//  Question.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

struct Question{
    
    var nickname: String?
    var userIcon: UIImage?
    var questionTitle: String?
    var questionText: String?
    var answers : [Answer] = []
    
    init(nickname: String?, userIcon: UIImage?, questionTitle: String?, questionText: String?, answers: [Answer])
    {
        
//        let novaQuestao = PFObject(className: "Question")
//        novaQuestao["textoPergunta"] = questionText
//        novaQuestao["tituloPergunta"] = questionTitle
//        novaQuestao["usuarioPergunta"] = "jO84U8Q9iE"
//        novaQuestao["upvotePergunta"] = Int(arc4random_uniform(420))
//        novaQuestao["comentariosPergunta"] = Int(arc4random_uniform(420))
//        
//        novaQuestao.saveInBackground()
        
        
        self.nickname = nickname
        self.userIcon = userIcon
        self.questionText = questionText
        self.questionTitle = questionTitle
        self.answers = answers
        
    }
    
}