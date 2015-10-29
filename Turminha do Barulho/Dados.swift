//
//  Dados.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

struct Dados {
    
    var titulo : String?
    var subtitulo : String?
    var texto: String?
    var imagem: UIImage?
    var upvote: Int?
    var upvoted:Bool = false

    
    init (titulo: String?, subtitulo: String?, texto: String?, imagem: UIImage?, upvote: Int? = 0)
    {
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.texto = texto
        self.imagem = imagem
        self.upvote = upvote
        self.upvoted = false
    }
    
    
    
}