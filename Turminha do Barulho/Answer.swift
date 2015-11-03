//
//  Answer.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/2/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

struct Answer{
    
    var nickname: String?
    var userIcon: UIImage?
    var answerText: String?
    
    init(nickname: String?, userIcon: UIImage?, answerText: String?)
    {
        self.nickname = nickname
        self.userIcon = userIcon
        self.answerText = answerText
        
    }
    
}
