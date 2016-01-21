//
//  Dados.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit
import Parse

struct Dados {
    
    var titulo : String?
    var subtitulo : String?
    var texto: String?
    var file: PFFile?
    var imagem: UIImage
    var upvote: Int?
    var upvoted:Bool = false
    var fulltext: String
    var id : String
    var date : NSDate

    
    init (titulo: String?, subtitulo: String?, texto: String?, file: PFFile, upvote: Int? = 0, fulltext: String, id: String, date: NSDate)
    {
        
//        let novaNoticia = PFObject(className: "Noticia")
//        novaNoticia["titulo"] = titulo
//        novaNoticia["texto"] = texto
//        novaNoticia["textoInteiro"] = fulltext
//        novaNoticia["tags"] = subtitulo
//        novaNoticia["upvote"] = upvote
//        
//        novaNoticia.saveInBackground()
//        
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.texto = texto
        self.file = file
        self.upvote = upvote
        self.upvoted = false
        self.fulltext = fulltext
        self.id = id
        self.imagem = UIImage(named: "userIcon")!
        self.date = date
    }
    
    
}
