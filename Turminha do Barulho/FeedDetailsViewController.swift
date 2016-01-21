//
//  FeedDetailsViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class FeedDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, novaResposta{
    
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
    
    
    let bgColor = UIColor(red: 27/255, green: 55/255, blue: 76/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    let tableBG = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1) //Cor do fundo apenas da tableview
    
    
    override func viewDidLoad() {
        
        
        self.navigationController?.navigationBarHidden = false
        
        self.detailsTableView.registerNib(UINib(nibName: "DetalhesNoticiaCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        self.detailsTableView.registerNib(UINib(nibName: "ComentarioDetalhes", bundle: nil), forCellReuseIdentifier: "comentarioDetalhes")
        
        detailsTableView.estimatedRowHeight = 700
        detailsTableView.rowHeight = UITableViewAutomaticDimension
       
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.detailsTableView.separatorStyle = .SingleLine
        
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
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.popViewControllerAnimated(true)
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
    
//    func populateNewsDetails(cell: NewsDetailCell!)
//    {
//        cell.imagem.image = self.passedCell.imagem
//        cell.categoriaTitle.text = self.passedCell.titulo
//        cell.subTitle.text = self.passedCell.subtitulo
//        cell.fullText.text = self.passedCell.fulltext
//        //Metodo de resolucao da celula, TO DO
//    }
    
//    func receiveCellData(cell: FeedCell) {
//        self.passedCell = cell;
//    }

    
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
            
//            passedCell.imagem?.getDataInBackgroundWithBlock({ (result, error) -> Void in
//                
//                cell.imagem.image = UIImage(data: result!)
//                
//            })
            cell.imagem.image = passedCell.imagem
            
            //PROVISORIO
            
            cell.id = self.passedCell.id
            
            cell.isVoted = passedCell.upvoted
            cell.configButton()
            cell.upVoteButton.enabled = false
            
            if isLogged{
                
                cell.upVoteButton.enabled = true
                
            }
            
            cell.categoriaTitle.text = self.passedCell.titulo
            cell.subTitle.text = self.passedCell.subtitulo
            cell.fullText.text = self.passedCell.fulltext
            cell.fullText.font = UIFont(name: "Futura", size: self.fontSize[self.actualFontSize])
            cell.fullText.sizeToFit()
            cell.prepareCell()
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("comentarioDetalhes", forIndexPath: indexPath) as! ComentarioDetalhesCell
            let index = indexPath.row - 1
            
            let info = self.commentArray[index] as Answer
            cell.commentText.text = info.answerText
            cell.commentText.sizeToFit()
            //cell.updateConstraints()
            //PRECISAMOS ALTERAR A MANEIRA COMO A CELULA EH POPULADA
            cell.userImage.image = UIImage(named: "userIcon")
            cell.userImage.layer.masksToBounds = true
            cell.userImage.layer.cornerRadius = cell.userImage.frame.height/2
            info.userIcon?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                
                cell.userImage.image = UIImage(data: data!)
                
            })
            cell.userName.text = info.nickname
            cell.numberOfLikes = info.upvote
            cell.cellSetup()
            return cell //A priori
        }
    }
    
    
    //#MARK - TextField e criar novo comentário
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let user = PFUser.currentUser()?.objectId
        
        if user != nil{
            performSegueWithIdentifier("criarComentário", sender: self)
            
            self.comentarTextField.endEditing(true)
        }
        else{
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! LoginViewController
            self.presentViewController(vc, animated: true, completion: nil)
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
                    
                }
                
            }
            
            self.activityIndicator.stopAnimating()
            
        }
        
    }
    
}
