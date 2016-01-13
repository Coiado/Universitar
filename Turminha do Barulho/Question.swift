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
    var userIcon:  PFFile?
    var questionTitle: String?
    var questionText: String?
    var answers :[Answer]?
    var id : String?
    var comentarios : Int?
    var upvotes: Int?
    var tags: String?
    var user: String
    
    init(nickname: String?, userIcon: PFFile?, questionTitle: String?, questionText: String?, answers: [Answer]?, id: String?, comentarios: Int?, upvotes: Int?, tags: String?, user: String)
    {
        
//        let novaQuestao = PFObject(className: "Question")
//        novaQuestao["textoPergunta"] = questionText
//        novaQuestao["tituloPergunta"] = questionTitle
//        novaQuestao["usuarioPergunta"] = "jO84U8Q9iE"
//        novaQuestao["upvotePergunta"] = Int(arc4random_uniform(420))
//        novaQuestao["comentariosPergunta"] = Int(arc4random_uniform(420))
//        
//        novaQuestao.saveInBackground()
        
        
        self.user = user
        self.nickname = nickname
        self.userIcon = userIcon
        self.questionText = questionText
        self.questionTitle = questionTitle
        self.answers = answers
        self.id = id
        self.comentarios = comentarios
        self.upvotes = upvotes
        self.tags = tags
    }
    
}