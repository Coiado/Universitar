//
//  Question.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

struct Question{
    
    var nickname: String?
    var userIcon: UIImage?
    var questionTitle: String?
    var questionText: String?
    
    init(nickname: String?, userIcon: UIImage?, questionTitle: String?, questionText: String?)
    {
        self.nickname = nickname
        self.userIcon = userIcon
        self.questionText = questionText
        self.questionTitle = questionTitle
        
    }
    
}