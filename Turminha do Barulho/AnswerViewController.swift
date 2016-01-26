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

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, UIScrollViewDelegate, novaResposta, QuestionFeedCellDelegate {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newQuestion: UITextField!
    @IBOutlet var tableViewQuestion: UITableView!
    
    var question : Question?
    
    var comentarios = [Answer]()
    
    var refreshControl : UIRefreshControl!
    
    // Dicionario para imagens
    var imagesDictionary = [String:UIImage]()
    
    var actualCell : AnswerTableViewCell?
    
    //QUANDO QUISER ALTERAR UMA COR ALTERE AQUI =)
    //Colors
    let bgColor = UIColor(red: 27/255, green: 55/255, blue: 76/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    let tableBG = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //Cor do fundo apenas da tableview
    
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
    
    
    //MARK: - Load more answer
    
    let threshold: CGFloat = -30.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            self.isLoadingMore = true
            getMoreRespostas()
            
        }
    }
    
    func getMoreRespostas(){
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findMoreComents((self.question?.id)!, skip: self.comentarios.count) { (array, error) -> Void in
            
            if error == nil{
                
                if let array = array{
                    
                    self.comentarios = self.comentarios + array
                    self.tableViewQuestion.reloadData()
                    self.isLoadingMore = false
                    
                }
                
                
            }
            
            self.activityIndicator.stopAnimating()
        }
        
    }
        
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
        self.imagesDictionary.removeAll()
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
            
            cell.selectionStyle = .None
            
            let now = NSDate()
            
            cell.dateLabel.text = now.offsetFrom(self.question!.date)
            
            let file = String(question!.userIcon)
            
            if let image = self.imagesDictionary[file]{
                
                cell.userIcon.image = image
                
            }
            else{
                
                if let file = question!.userIcon {
                    ParseModel.getImage(file, completionHandler: { (data, error, file) -> Void in
                        
                        if error == nil {
                            
                            let image = UIImage(data: data!)
                            let file = String(self.question!.userIcon)
                            cell.userIcon.image = image
                            self.imagesDictionary[file] = image
                            
                        }
                        else{
                            
                            cell.userIcon.image = UIImage(named: "userIcon")
                            
                        }
                        
                    })
                    
                }
                else{
                    
                    cell.userIcon.image = UIImage(named: "userIcon")
                    
                }
            }
            
            cell.userIcon.layer.masksToBounds = true
            cell.userIcon.layer.cornerRadius = 15
            cell.nickName.text = self.cortarNickname((question?.nickname)!)
            cell.questionText.text = self.question!.questionText
            cell.questionText.font = UIFont(name: "Futura", size: 14.0)
            cell.questionText.sizeToFit()
            cell.updateConstraints()
            //cell.cardSetup()
            
            cell.delegate = self
            
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
                cell.usuario = self.cortarNickname(info.nickname!)
                cell.usuarioId = info.userId
            
                let file = String(info.userIcon)
                
                if let image = self.imagesDictionary[file]{
                    
                    cell.userIcon.image = image
                    
                }
                else{
                    
                    if let file = info.userIcon {
                        ParseModel.getImage(file, completionHandler: { (data, error, file) -> Void in
                            
                            if error == nil {
                                
                                let image = UIImage(data: data!)
                                let file = String(info.userIcon)
                                cell.userIcon.image = image
                                self.imagesDictionary[file] = image
                                
                            }
                            else{
                                
                                cell.userIcon.image = UIImage(named: "userIcon")
                                
                            }
                            
                        })
                        
                    }
                    else{
                        
                        cell.userIcon.image = UIImage(named: "userIcon")
                        
                    }
                }
            
                cell.isTextTooBig = false
            
                let now = NSDate()
            
                let stringDate = now.offsetFrom(info.date)
            
                cell.answerDate.text = stringDate
            
                cell.denunciaButton.addTarget(self, action: "denunciaComentario:", forControlEvents: UIControlEvents.TouchUpInside)
            
                cell.denunciaButton.tag = index

                cell.userIcon.layer.masksToBounds = true
                cell.userIcon.layer.cornerRadius = 15
                cell.nickName.text = self.cortarNickname(info.nickname!) 
                cell.nickName.font = UIFont(name: "Futura", size: 13.0)
                cell.answerText.text = info.answerText
                cell.answerText.font = UIFont(name: "Futura", size: 14.0)
                cell.formatText()
                cell.answerText.sizeToFit()
                cell.updateConstraints()
                //cell.cardSetup()
                return cell
            }
        }
    }
    
    func denunciaComentario(sender: AnyObject){
        
        let id = self.comentarios[sender.tag].id
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findDenuncia(id!) { (object, error) -> Void in
            
            if error == nil {
                
                
                ParseModel.aumentarDenuncia(object!, completionHandler: { (sucesso, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    if error == nil{
                        self.denunciaFeita()
                    }
                    else{
                        
                        let alert = ParseErrorHandler.errorHandler((error?.code)!)
                        
                        self.presentViewController(alert, animated: true, completion: nil)

                    }
                    
                    
                })
            }else{
                
                ParseModel.criarDenuncia(id!, completionHandler: { (sucesso, error) -> Void in
                   
                    self.activityIndicator.stopAnimating()

                    if error == nil {
                        
                        self.denunciaFeita()
                        
                    }
                    else{
                        
                        let alert = ParseErrorHandler.errorHandler((error?.code)!)
                        
                        self.presentViewController(alert, animated: true, completion: nil)

                    }
                  
                                        
                })
                
            }
            
        }
        
    }
    
    func denunciaFeita(){
        
        let alertController = UIAlertController(title: "Denuncia realiza", message: "Obrigado, sua denuncia foi realizada com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
                        else{
                            
                            let alert = ParseErrorHandler.errorHandler((error?.code)!)
                            
                            self.presentViewController(alert, animated: true, completion: nil)

                        }
                    })
                    self.pegarComentarios()
                }
                else{
                    
                    let alert = ParseErrorHandler.errorHandler((error?.code)!)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            })
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? AnswerTableViewCell{
        
            if cell.isTextTooBig! {
                
                self.actualCell = cell
                
                self.performSegueWithIdentifier("verMais", sender: self)
            }
        }
        
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let user = PFUser.currentUser()?.objectId
        if user != nil{
            performSegueWithIdentifier("responderPergunta", sender: self)
            self.newQuestion.endEditing(true)
        }
        else{
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "responderPergunta"{
            let destination = segue.destinationViewController as! CriaRespostaViewController
            
            destination.respostaDelegate = self
        }
        if segue.identifier == "verMais"
        {
            
            let destination = segue.destinationViewController as! AnswerDetailTableViewController
            
            destination.passedCell = self.actualCell!
            
            
        }
    }
    
    func didClickDenunciaButtonForCell(cell: QuestionFeedCell) {
        
        let id = self.question?.id
        self.activityIndicator.startAnimating()
        
        ParseModel.findDenuncia(id!) { (object, error) -> Void in
            
            if error == nil {
                
                
                ParseModel.aumentarDenuncia(object!, completionHandler: { (sucesso, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    if error == nil{
                        self.denunciaFeita()
                    }
                    else{
                        
                        let alert = ParseErrorHandler.errorHandler((error?.code)!)
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                })
            }else{
                
                ParseModel.criarDenuncia(id!, completionHandler: { (sucesso, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    if error == nil {
                        
                        self.denunciaFeita()
                        
                    }
                    else{
                        
                        let alert = ParseErrorHandler.errorHandler((error?.code)!)
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                })
                
            }
            
        }

    
    }
    
    func cortarNickname(nickname: String) -> String{
        var nick = nickname.componentsSeparatedByString(" ")
        if(nick.count<2){
            return nick[0]
        }
        else{
            return (nick[0] + " " + nick[1])
        }
    }

}
