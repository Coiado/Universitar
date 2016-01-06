//
//  Answer.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/2/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

struct Answer{
    
    var nickname: String? // mudar para USUARIO depois
    var userIcon: UIImage?
    var answerText: String?
    var upvote: Int?
    var id: String?
    
    init(nickname: String?, userIcon: UIImage? = nil, answerText: String? = "teste", upvote: Int? = 0, id: String? = "97")
    {
        
//        let novaAtividade = PFObject(className: "Atividade")
//        novaAtividade["tipo"] = "Resposta"
//        novaAtividade["para"] = "RkkswrqiQw"
//        novaAtividade["deUsuario"] = "jO84U8Q9iE"
//        novaAtividade["conteudo"] = answerText
//        novaAtividade["paraUsuario"] = "jO84U8Q9iE"
//        
//        novaAtividade.saveInBackground()

        
        self.nickname = nickname
        self.userIcon = userIcon
        self.answerText = answerText
        self.upvote = upvote
        self.id = id
        
    }
    
}
