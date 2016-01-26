//
//  FeedDetailsViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class FeedDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, novaResposta, NewsDetailCellDelegate{
    
    @IBOutlet weak var aumentaLetra: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var comentarTextField: UITextField!
    
    //TableView
    @IBOutlet weak var detailsTableView : UITableView!
    
    //aumenta letra
    let fontSize:[CGFloat] = [17.0, 20.0, 23.0]
    
    var actualFontSize:Int = 0
    
    //Dados das noticias, devemos usar para mandar para nossa TableView
    var passedCell: Dados!
    
    //Vetor com os comentarios
    var commentArray: [Answer] = []

    var isLogged : Bool = false
    
    //Celula da noticia
    var newsCell : NewsDetailCell!
    
    var refreshControl : UIRefreshControl!
    
    // Dicionario para imagens
    var imagesDictionary = [String:UIImage]()
    
    
    let bgColor = UIColor(red: 27/255, green: 55/255, blue: 76/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    let tableBG = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1) //Cor do fundo apenas da tableview
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.imagesDictionary.removeAll()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        
        
        self.navigationController?.navigationBarHidden = false
        
        self.detailsTableView.registerNib(UINib(nibName: "DetalhesNoticiaCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        self.detailsTableView.registerNib(UINib(nibName: "ComentarioDetalhes", bundle: nil), forCellReuseIdentifier: "comentarioDetalhes")
        
        detailsTableView.estimatedRowHeight = 700
        detailsTableView.rowHeight = UITableViewAutomaticDimension
       
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.detailsTableView.separatorStyle = .SingleLine
        self.detailsTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8)
        
        if PFUser.currentUser() != nil {
        
            self.isLogged = true
            
            ParseModel.findLike(self.passedCell.id) { (existe, error) -> Void in
                
                self.passedCell.upvoted = existe
                self.detailsTableView.reloadData()
            
            }
        }
        
        else{
            self.passedCell.upvoted = false
        }
        
        self.aumentaLetra.addTarget(self, action: "aumentaLetra:", forControlEvents: UIControlEvents.TouchUpInside)
        
        configRefresh()
        
        pegarComentarios()
        
        self.detailsTableView.remembersLastFocusedIndexPath = true
        
    }
    
    
    //MARK: - aumenta letra
    
    func aumentaLetra(sender:AnyObject){
        
        let size = self.actualFontSize + 1
        
        if size < self.fontSize.count{
            
            self.actualFontSize = size
            
        }
        else{
            
            self.actualFontSize = 0
            
        }
        
        
        
        self.detailsTableView.reloadData()
        
    }
    
    //MARK: - Refresh
    
    func configRefresh(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = bgColor
        self.refreshControl!.tintColor = detailsColor
        self.refreshControl!.addTarget(self, action: "refreshTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.detailsTableView.addSubview(self.refreshControl!)
        
    }
    
    func refreshTableView(sender: AnyObject){
        
        self.pegarComentarios()
        self.refreshControl.endRefreshing()
    }
    
    
    func pegarComentarios(){
        
        let id = (self.passedCell.id)
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findComents(id) { (array, error) -> Void in
            
            if error == nil {
                self.commentArray = array!
                self.detailsTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        
    }

    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
        
    }
    
    //TableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Noticia + comentarios
        return 1 + self.commentArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //Muda de identifier para identifier
        var height : CGFloat
        if (indexPath.row==0){
            //Provisorio
            height = 1000;
        }
        else{
            height = 200.0
        }
        return height;
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Precisamos retornar uma celula de noticia caso seja a primeira celula ou celulas de comentarios
        if (indexPath.row==0){
            let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as! NewsDetailCell
            
            cell.imagem.image = passedCell.imagem
            
            //PROVISORIO
            
            cell.id = self.passedCell.id
            
            cell.isVoted = passedCell.upvoted
            cell.configButton()
            cell.upVoteButton.enabled = true
            
            if isLogged{
                
                cell.upVoteButton.enabled = true
                
            }
            
            let date = passedCell.date
            
            cell.dateLabel.text = date.dateToString(date)
            
            cell.categoriaTitle.text = self.passedCell.titulo
            cell.subTitle.text = self.passedCell.subtitulo
            cell.fullText.text = self.passedCell.fulltext
            cell.fullText.sizeToFit()
            cell.prepareCell()
            cell.delegate = self
            
            cell.fullText.font = UIFont.systemFontOfSize(self.fontSize[self.actualFontSize])
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("comentarioDetalhes", forIndexPath: indexPath) as! ComentarioDetalhesCell
            let index = indexPath.row - 1
            
            let info = self.commentArray[index] as Answer
            cell.commentText.text = info.answerText
            cell.commentText.sizeToFit()
            //cell.updateConstraints()
            //PRECISAMOS ALTERAR A MANEIRA COMO A CELULA EH POPULADA
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = cell.userImage.frame.height/2
            
            let file = String(info.userIcon)
            
            if let image = self.imagesDictionary[file]{
                
                cell.userImage.image = image
                
            }
            else{
                
                if let file = info.userIcon {
                    ParseModel.getImage(file, completionHandler: { (data, error, file) -> Void in
                        
                        if error == nil {
                            
                            let image = UIImage(data: data!)
                            let file = String(info.userIcon)
                            cell.userImage.image = image
                            self.imagesDictionary[file] = image
                            
                        }
                        else{
                            
                            cell.userImage.image = UIImage(named: "userIcon")
                            
                        }
                        
                    })
                    
                }
                else{
                    
                    cell.userImage.image = UIImage(named: "userIcon")
                    
                }
            }
            
            cell.userName.text = info.nickname
            cell.numberOfLikes = info.upvote
            cell.cellSetup()
            
            cell.flagButton.tag = index
            cell.flagButton.addTarget(self, action: "denunciarComentario:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell //A priori
        }
    }
    
    func denunciarComentario(sender:AnyObject){
        
        
        self.activityIndicator.startAnimating()
        
        let id = self.commentArray[sender.tag].id
        
        if let user = PFUser.currentUser(){
        
            ParseModel.findDenuncia(id!) { (object, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                
                if error == nil {
                    
                    let alert = UIAlertController(title: "Denúncia", message: "Você já denunciou esse comentário, vamos analisar, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                    })
                    
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                else {
                    
                    let alert = UIAlertController(title: "Denúncia", message: "Fale o motivo da denúncia que vamos analisar, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    var titleTextField: UITextField?
                    alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
                        titleTextField = textField
                        textField.placeholder = "Motivo"
                    }
                    
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
                    
                    alert.addAction(cancelAction)
                    
                    let action = UIAlertAction(title: "Enviar", style: .Default, handler: { (UIAlertAction) -> Void in
                        
                        if let text = titleTextField?.text{
                            ParseModel.criarDenuncia(id!,motivo: text, completionHandler: { (sucesso, error) -> Void in
                                
                                if error == nil {
                                    
                                    self.denunciaFeita()
                                }
                                
                            })
                        }
                    })
                    
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
            }
        }
        else{
            
            self.activityIndicator.stopAnimating()
            
            let alert = UIAlertController(title: "Denúncia", message: "Para seguir essa ação por favor fazer login, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Login", style: .Default, handler: { (UIAlertAction) -> Void in
                
                let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
                self.presentViewController(vc, animated: true, completion: { () -> Void in
                    
                    
                })
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .Default, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func denunciaFeita(){
        
        let alertController = UIAlertController(title: "Denúncia realiza", message: "Obrigado, sua denúncia foi realizada com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    //#MARK - TextField e criar novo comentário
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let user = PFUser.currentUser()?.objectId
        
        if user != nil{
            self.comentarTextField.endEditing(true)
            performSegueWithIdentifier("criarComentário", sender: self)
        }
        else{
            let alert = UIAlertController(title: "Cometário", message: "Para seguir essa ação por favor fazer login, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Login", style: .Default, handler: { (UIAlertAction) -> Void in
                
                let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
                self.presentViewController(vc, animated: true, completion: { () -> Void in
                    
                    
                })
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .Default, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)

        }
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "criarComentário"
        {
            let destination = segue.destinationViewController as! CriaRespostaViewController
            
            destination.respostaDelegate = self // seta o delegate do viewcontroller
        }
    }
    
    func salvarNovaResposta(text:String){ //metodo para adicionar novo comentário
        
        if(text != ""){
            
            let para = self.passedCell.id
            
            ParseModel.salvarAtividade(para, paraUsuario: "", conteudo: text, tipo: "Comentario",completionHandler: { (sucesso, error) -> Void in
                if error == nil{
                    
                    ParseModel.aumentarComentarioNoticia(para, completionHandler: { (sucesso, error) -> Void in
                        //fzer algo
                    })
                    
                    self.pegarComentarios()
                    
                }
                else{
                    
                    
                    let alert = ParseErrorHandler.errorHandler((error?.code)!)
                    
                    self.presentViewController(alert, animated: true, completion: nil)

                    
                }
            })
            
            self.detailsTableView.reloadData()
        }
    }
    
    //MARK: - Metodos para carregar mais
    
    let threshold: CGFloat = -5.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            self.isLoadingMore = true
            
            getMoreComments()
        }
    }
    

    
    func getMoreComments(){
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findMoreComents(self.passedCell.id, skip: self.commentArray.count) { (array, error) -> Void in
        
            if error == nil{
                
                if let array = array {
                    
                    self.commentArray = self.commentArray + array
                    self.detailsTableView.reloadData()
                    self.isLoadingMore = false
                    
                    if self.commentArray.count > 1 {
                        self.detailsTableView.scrollToNearestSelectedRowAtScrollPosition(UITableViewScrollPosition.Bottom, animated: true)
                    }
                }
                
            }
            
            self.activityIndicator.stopAnimating()
            
        }
        
    }
    
    func clickLike(cell: NewsDetailCell){
        let alert = UIAlertController(title: "Curtir", message: "Para seguir essa ação por favor fazer login, obrigado.", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Login", style: .Default, handler: { (UIAlertAction) -> Void in
            
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                
                
            })
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
}
