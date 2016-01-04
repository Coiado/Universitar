//
//  ParseModel.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/12/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class ParseModel {
    
    static func findAllNews()-> [Dados]{
        
        let query = PFQuery(className: "Noticia")

        var array : [Dados]!
        // funcao para pegar todas as noticias
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                if let objects = objects {
                    for object in objects {
                        //pegar os PFObject e transformar no estilo Dados
                        let titulo = object["titulo"] as! String
                        let texto = object["texto"] as! String
                        let textoInteiro = object["textoInteiro"] as! String
                        let tags = object["tags"] as! String
                        let upvote = object["upvote"] as! Int
                        //let imagem = object["imagem"] as! NAO SEI
                        
                        let dados = Dados(titulo: titulo, subtitulo: tags, texto: texto, imagem: nil, upvote: upvote, fulltext: textoInteiro)
                        
                        array.append(dados)
                        
                    }
                }
            }
            
        }
        return array
    }
    
    static func findAllComents(from:String) -> [Answer]{
        
        let query = PFQuery(className: "Atividade")

        query.whereKey("para", equalTo: from)
        
        var array : [Answer]!
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                if let objects = objects{
                    
                    for object in objects{
                        
                        let nick = object["deUsuario"] as! String
                        //let icon = nao sei
                        let text = object["conteudo"] as! String
                        
                        let answer = Answer(nickname: nick, answerText: text)
                        
                        array.append(answer)
                        
                    }
                    
                }
                
            }
            
            
        }
        
        return array
        
    }
    
    
//    static func findAllQuestion() -> [Question]{
//        
//        let query = PFQuery(className: "Question")
//        
//        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error) -> Void in
//            
//            if error == nil{
//                
//                if let objects = objects{
//                    
//                    for object in objects{
//                    
//                        let text = object["textoPergunta"] as! String
//                        
//                        let titulo = object["tituloPergunta"] as! String
//                        
//                        let tags = object["tagsPergunta"] as! String
//                        
//                        let upvote = object["upvotePergunta"] as! Int
//                    
//                        let comentarios = object["comentariosPergunta"] as! Int
//                        
//                        let user = object["usuarioPergunta"] as! String
//                        
//                        
//                    }
//                
//                }
//                
//            }
//            
//        }
//        
//        
//    }
    
    
    
}





