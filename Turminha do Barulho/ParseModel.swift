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
    
    
    //MARK: - pegar informaçoes
    
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
                        let imagem = object["imagem"] as! PFFile
                        let id = (object.objectId)!
                        
                        let dados = Dados(titulo: titulo, subtitulo: tags, texto: texto, imagem: imagem, upvote: upvote, fulltext: textoInteiro,id: id)
                        
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
                        
                    }
                    else
                    {
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
                    let usuario = object["deUsuario"] as? String
                    let upvote = object["upvote"] as? Int
                    let id = (object.objectId)!
                    
                    let answer = Answer(nickname: usuario, answerText: conteudo, upvote: upvote,id: id)
                    
                    array.append(answer)
                    
                }
                
                completionHandler(array: array, error: nil)
                
            }
            else{
                completionHandler(array: nil, error: error)
            }
        }
        
    }
    
    
    
    static func findAllNotifications(){
        
        let user = (PFUser.currentUser()?.objectId)!
        
        let query = PFQuery(className: "Atividade")
        
        query.whereKey("paraUsuario", equalTo: user)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                //criar tipo notificacao
                
            }
            else{
                
            }
        }
        
    }
    
    
    static func findDenuncia(comentario: String, completionHandler:(object:PFObject?, error: NSError?)->Void){
        
        let query = PFQuery(className: "Denuncia")
        query.whereKey("comentario", equalTo: comentario)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                completionHandler(object: object, error: nil)
            }
            else{
                
                completionHandler(object: nil, error: error)
                
            }
        }
        
    }
    
    
//    static func findUser(user: String, completionHandler:(object:User?, error:NSError? ) -> Void){
//        
//        
//        
//    }
    
    
    //MARK: - Salvar
    
    
    static func salvarAtividade(para: String, paraUsuario: String, conteudo: String,tipo:String, completionHandler:(sucesso: Bool, error: NSError?) -> Void){
        
        let comentario = PFObject(className: "Atividade")
        
        comentario["para"] = para
        comentario["paraUsuario"] = paraUsuario
        comentario["conteudo"] = conteudo
        comentario["tipo"] = tipo
        comentario["upvote"] = 0
        
        if let user = PFUser.currentUser()?.objectId {

        comentario["deUsuario"] = user
            
        }
        else{
            let null = NSNull()

            comentario["deUsuario"] = null

        }
        comentario.saveInBackgroundWithBlock { (Bool, error) -> Void in
            
            if error == nil{
                completionHandler(sucesso: true, error: nil)
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
        }
        
    }
    
    static func salvarPergunta(titulo: String, tags: String, texto:String, completionHandler:(sucesso:Bool, error: NSError?) -> Void){
        
        let user = (PFUser.currentUser()?.objectId)!
        
        let pergunta = PFObject(className: "Question")
        pergunta["textoPergunta"] = texto
        pergunta["tituloPergunta"] = titulo
        pergunta["tagsPergunta"] = tags
        pergunta["upvotePergunta"] = 0
        pergunta["comentariosPergunta"] = 0
        pergunta["usuarioPergunta"] = user
        
        pergunta.saveInBackgroundWithBlock { (Bool, error) -> Void in
            if error == nil {
                
                completionHandler(sucesso: true, error: nil)
                
            }else{
                completionHandler(sucesso: false, error: error)
            }
        }
        
    }
    
    static func salvarNovoLike(para: String,usuario: String, completionHandler:(sucesso:Bool, error: NSError?)->Void){
        
        let user = PFUser.currentUser()?.objectId
        
        let like = PFObject(className: "Atividade")
        like["tipo"] = "Upvote"
        like["para"] = para
        like["deUsuario"] = user!
        like["paraUsuario"] = usuario
        like.saveInBackgroundWithBlock { (Bool, error) -> Void in
            
            if error == nil{
                completionHandler(sucesso: true, error: nil)
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
            
        }
        
    
    }
    
    
    static func criarDenuncia(comentario: String, completionHandler:(sucesso:Bool, error: NSError?)->Void){
        
        let denuncia = PFObject(className: "Denuncia")
        denuncia["comentario"] = comentario
        denuncia["denuncias"] = 1
        
        denuncia.saveInBackgroundWithBlock { (Bool, error) -> Void in
            
            if error == nil {
                
                completionHandler(sucesso: true, error: nil)
                
            }
            else{
                
                completionHandler(sucesso: false, error: error)
                
            }
        }
        
    }
    
    //MARK: - Atualizar objetos
    
    static func aumentarDenuncia(denuncia:PFObject, completionHandler: (sucesso:Bool, error: NSError?)-> Void){
    
        let denuncias = denuncia["denuncias"] as! Int
        denuncia["denuncias"] = denuncias + 1
        denuncia.saveInBackgroundWithBlock { (Bool, error) -> Void in
            
            if error == nil {
                
                completionHandler(sucesso: true, error: nil)
                
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
        }
    }
    
    
    static func aumentarComentarioPergunta(id: String,completionHandler:(sucesso:Bool,error: NSError?) -> Void){
        
        let query = PFQuery(className: "Question")
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            
            if error == nil{
                
                let atual = object!["comentariosPergunta"] as! Int
                
                object!["comentariosPergunta"] = atual + 1
                
                object?.saveInBackgroundWithBlock({ (Bool, error) -> Void in
                    
                    if error == nil {
                        completionHandler(sucesso: true, error: nil)
                    }
                    else{
                        completionHandler(sucesso: false, error: error)
                    }
                })
                
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
            
        }
        
    }
    
    
    static func aumentarLikeComentario(id:String, completionHandler:(sucesso:Bool,error: NSError?) -> Void){
        
        let query = PFQuery(className: "Atividade")
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            
            if error == nil{
                
                let atual = object!["upvote"] as! Int
                
                object!["upvote"] = atual + 1
                
                object?.saveInBackgroundWithBlock({ (Bool, error) -> Void in
                    
                    if error == nil {
                        completionHandler(sucesso: true, error: nil)
                    }
                    else{
                        completionHandler(sucesso: false, error: error)
                    }
                })
                
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
            
        }
        
    }
    
    static func diminuirLikeComentario(id:String, completionHandler:(sucesso:Bool,error: NSError?) -> Void){
        
        let query = PFQuery(className: "Atividade")
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            
            if error == nil{
                
                let atual = object!["upvote"] as! Int
                
                object!["upvote"] = atual - 1
                
                object?.saveInBackgroundWithBlock({ (Bool, error) -> Void in
                    
                    if error == nil {
                        completionHandler(sucesso: true, error: nil)
                    }
                    else{
                        completionHandler(sucesso: false, error: error)
                    }
                })
                
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
            
        }
        
    }
    
    
    static func aumentarComentarioNoticia(id: String,completionHandler:(sucesso:Bool,error: NSError?) -> Void){
        
        let query = PFQuery(className: "Noticia")
        query.getObjectInBackgroundWithId(id) { (object, error) -> Void in
            
            if error == nil{
                
                let atual = object!["comentarios"] as! Int
                
                object!["comentarios"] = atual + 1
                
                object?.saveInBackgroundWithBlock({ (Bool, error) -> Void in
                    
                    if error == nil {
                        completionHandler(sucesso: true, error: nil)
                    }
                    else{
                        completionHandler(sucesso: false, error: error)
                    }
                })
                
            }
            else{
                completionHandler(sucesso: false, error: error)
            }
            
        }

    }
    
    
    //MARK: - Apagar
    
    static func apagarLike(para:String, completionHandler:(sucesso:Bool, error:NSError?) -> Void){
        
        let query = PFQuery(className: "Atividade")
        let deUsuario = (PFUser.currentUser()?.objectId)!
        
        
        query.whereKey("para", equalTo: para)
        query.whereKey("deUsuario", equalTo: deUsuario)
        query.whereKey("tipo", equalTo: "Upvote")
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            
            if error == nil {
                
                object?.deleteInBackgroundWithBlock({ (Bool, error) -> Void in
                    if error == nil{
                        
                        completionHandler(sucesso: true, error: nil)
                        
                    }
                    else{
                        completionHandler(sucesso: false, error: error)
                    }
                })
                
            }
            
        }
        
        
        
    }
    
    
}//parse models






