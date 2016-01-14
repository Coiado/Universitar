//
//  AnswerViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/2/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

protocol novaResposta {
    func salvarNovaResposta(text:String)
}

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, novaResposta{

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newQuestion: UITextField!
    @IBOutlet var tableViewQuestion: UITableView!
    
    var question : Question?
    
    var comentarios = [Answer]()
    
    var refreshControl : UIRefreshControl!
    
    override func viewDidAppear(animated: Bool) {
        self.tableViewQuestion.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newQuestion.enabled = true
        tableViewQuestion.estimatedRowHeight = 90
        tableViewQuestion.rowHeight = UITableViewAutomaticDimension
        self.tableViewQuestion.separatorStyle = UITableViewCellSeparatorStyle.init(rawValue: 1)!
        pegarComentarios()
        configRefresh()
    }
    
    
    //MARK: - Refresh
    
    let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    func configRefresh(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = bgColor
        self.refreshControl!.tintColor = detailsColor
        self.refreshControl!.addTarget(self, action: "refreshTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableViewQuestion.addSubview(self.refreshControl!)
        
    }
    
    func refreshTableView(sender: AnyObject){
        
        self.pegarComentarios()
        self.refreshControl!.endRefreshing()
    }
    
    
    func pegarComentarios(){
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findComents((self.question?.id)!) { (array, error) -> Void in
            
            if error == nil{
                
                self.comentarios = array!

                self.tableViewQuestion.reloadData()
                
                self.activityIndicator.stopAnimating()
                
            }
            
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comentarios.count + 2
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            
            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionFeedCell
            
            cell.perguntaTitulo.text = self.question!.questionTitle
            cell.perguntaTitulo.sizeToFit()
            cell.updateConstraints()
            cell.userIcon.image = UIImage(named: "userIcon")
            
            question!.userIcon?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                
                cell.userIcon.image = UIImage(data: data!)
                
            })
            
            cell.userIcon.layer.masksToBounds = true
            cell.userIcon.layer.cornerRadius = 15
            cell.nickName.text = question?.nickname
            cell.questionText.text = self.question!.questionText
            cell.questionText.font = UIFont(name: "Futura", size: 14.0)
            cell.questionText.sizeToFit()
            cell.updateConstraints()
            //cell.cardSetup()
            
            return cell
        }
        else{if(indexPath.row==1){
            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
            let numberComments = String((self.question?.comentarios)!)
            cell.comments.text = numberComments + " Comentários:"
            cell.comments.font = UIFont(name: "Futura", size: 14.0)
            
            return cell
            }
            else{
                let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! AnswerTableViewCell
            
                let index = indexPath.row - 2
            
                let info = self.comentarios[index]
            
                cell.id = info.id
                cell.usuario = info.nickname
                cell.userIcon.image = UIImage(named: "userIcon")
                cell.usuarioId = info.userId
            
                info.userIcon?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    
                    cell.userIcon.image = UIImage(data: data!)
                    
                })
            
                cell.userIcon.layer.masksToBounds = true
                cell.userIcon.layer.cornerRadius = 15
                cell.nickName.text = info.nickname
                cell.nickName.font = UIFont(name: "Futura", size: 13.0)
                cell.answerText.text = info.answerText
                cell.answerText.font = UIFont(name: "Futura", size: 14.0)
                cell.answerText.sizeToFit()
                cell.updateConstraints()
                cell.likes.text = String(info.upvote!)
                //cell.cardSetup()
                return cell
            }
        }
    }

    
    func salvarNovaResposta(text:String){
        
        //fazer verificacao
        
        if(text != ""){
            
            let para = (self.question?.id)!
            let paraUsuario = (self.question?.user)!
            let conteudo = text
            let tipo = "Comentario"
            
            
            
            ParseModel.salvarAtividade(para, paraUsuario: paraUsuario, conteudo: conteudo, tipo: tipo, completionHandler: { (sucesso, error) -> Void in
                
                if error == nil{
                    ParseModel.aumentarComentarioPergunta(para, completionHandler: { (sucesso, error) -> Void in
                        if error == nil {
                            
                            self.tableViewQuestion.reloadData()
                            
                        }
                    })
                    self.pegarComentarios()
                }
                else{
                    //cuidar do erro
                }
                
            })
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let user = PFUser.currentUser()?.objectId
        if user != nil{
            performSegueWithIdentifier("responderPergunta", sender: self)
            self.newQuestion.endEditing(true)
        }
        else{
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! LoginViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "responderPergunta"{
            let destination = segue.destinationViewController as! CriaRespostaViewController
            
            destination.respostaDelegate = self
        }
    }
    

}
