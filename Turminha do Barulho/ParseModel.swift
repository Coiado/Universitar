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
    
    static func findAllNews(completionHandler: (array: [Dados]?, error: NSError?) -> Void){
        
        let query = PFQuery(className: "Noticia")

        var array = [Dados]()
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
                        
                    }//for
                    completionHandler(array: array, error: nil)
                }// if let
                
            }// if
            
            else{
                completionHandler(array: nil, error: error)
            }
            
        }//find
        
    }//func
    
    static func findAllComents(from:String, completionHandler:(array: [Answer]?, error: NSError?) -> Void){
        
        let query = PFQuery(className: "Atividade")

        query.whereKey("para", equalTo: from)
        
        var array = [Answer]()
        
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
                    
                    completionHandler(array: array, error: nil)
                    
                }//if let
                
                
            }// if
            
            else{
                
                completionHandler(array: nil, error: error)
                
            }
            
            
        } // completion
        
      
        
    }// func
    
    
    static func findAllQuestion(completionHandler: (array: [Question]?, error: NSError?) -> Void ){
        
        var array = [Question]()
        
        let query = PFQuery(className: "Question")
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error) -> Void in
            
            if error == nil{
                
                if let objects = objects{
                    
                    for object in objects{
                    
                        let text = object["textoPergunta"] as! String
                        
                        let titulo = object["tituloPergunta"] as! String
                        
                        let tags = object["tagsPergunta"] as! String
                        
                        let upvote = object["upvotePergunta"] as! Int
                    
                        let comentarios = object["comentariosPergunta"] as! Int
                        
                        let user = object["usuarioPergunta"] as! String
                        
                        let id = object.objectId
                        
                        let question = Question(nickname: nil, userIcon: nil, questionTitle: titulo, questionText: text, answers: nil, id: id, comentarios: comentarios, upvotes: upvote, tags: tags, user: user)
                        
                        array.append(question)
                        
                        
                    }//for
                
                    completionHandler(array: array, error: nil)
                    
                }//if let
                
            }// if
           
            else{
                
                completionHandler(array: nil, error: error)
                
            }
            
        }// completion
        
        
    }//func

    static func findAllMaterias(completionHandler: (array: [String]?, error: NSError?) -> Void){
        
        let query = PFQuery(className: "TodasMaterias")
        
        var array = [String]()
        
        query.orderByAscending("materia")
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error) -> Void in
            
            if error == nil{
                if let objects = objects{
                    
                    for object in objects{
                        
                        let materia = object["materia"] as! String
                        
                        array.append(materia)
                        
                    }// for
                    
                    completionHandler(array: array, error: nil)
                    
                }//if let
                
            }//if
            
            else{
                
                completionHandler(array: nil, error: error)
                
            }
        }//completion
        
    }
    
    static func findMateria(equalTo: String, completionHandler: ( object: MateriaDescricao?, error: NSError? ) -> Void){
        
        let query = PFQuery(className: "Materias")
        
        query.whereKey("nome", equalTo: equalTo)
        
        query.limit = 1
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error) -> Void in
            
            if error == nil{
                
                if let object = objects{
                
                    let curso = object[0]["nome"] as! String
                    let universidades = object[0]["universidades"] as! [String]
                    let descricao = object[0]["descricao"] as! String
                    
                    let materia = MateriaDescricao(curso: curso, universidades: universidades, descricao: descricao)
                    
                    completionHandler(object: materia, error: nil)
                
                }
            
            }
            else{
                completionHandler(object: nil, error: error)
            }
        }
        
    }
    
    
    static func findUniversidade(course: String, universidade: String, completionHandler: (object:String?, descricao:String? , error:NSError?) -> Void){
        
        let query = PFQuery(className: "Universidades")
        
        query.whereKey("curso", equalTo: course)
        query.whereKey("universidade", equalTo: universidade)
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error) -> Void in
            
            if error == nil{
                
                if let object = objects{
                    
                    let descricao = object[0]["descricaoUniversidade"] as! String
                    let id = object[0].objectId
                    
                    completionHandler(object: id, descricao: descricao, error: nil)
                    
                }
                
            }
            else{
                completionHandler(object: nil,descricao: nil, error: error)
            }
            
        }
    
    }
    
    
    static func findCourseInfos(curso: String, universidade: String, completionHandler: (object:CursoInfo?, error:NSError?) -> Void){
        
        self.findUniversidade(curso, universidade: universidade) { (object,descricao, error) -> Void in
            
            if error == nil{
                
                var array = [[String]]()
                
                let query = PFQuery(className: "Semestres")
                query.whereKey("curso", equalTo: object!)
                query.orderByAscending("numero")
                query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error:NSError?) -> Void in
                    if error == nil{
                        if let objects = objects{
                            for object in objects{
                                
                                array.append(object["semestre"]! as! [String])
                                
                            }
                        }
                        let cursoInfo = CursoInfo(curso: curso, universidade: universidade, descricaoUniversidade: descricao, semestres: array)
                        completionHandler(object: cursoInfo, error: nil)
                    }else{
                completionHandler(object: nil, error: error)
                    }
                })
                
            }
        }
    }
    
    
    
    static func findComents(para: String , completionHandler: (array:[Answer]?, error:NSError?) -> Void){
        
        let query = PFQuery(className: "Atividade")
        
        query.whereKey("para", equalTo: para)
        
        query.whereKey("tipo", equalTo: "Comentario")
        
        query.orderByAscending("createdAt")
        
        var array = [Answer]()
        
        query.findObjectsInBackgroundWithBlock { (objects, error:NSError?) -> Void in
            
            if error == nil{
                
                for object in objects! {
                    
                    let conteudo = object["conteudo"] as! String
                    let usuario = object["deUsuario"] as! String
                    
                    let answer = Answer(nickname: usuario, answerText: conteudo)
                    
                    array.append(answer)
                    
                }
                
                completionHandler(array: array, error: nil)
                
            }
            completionHandler(array: nil, error: error)
        }
        
    }
    
    
    
    
    
}






