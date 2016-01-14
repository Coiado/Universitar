//
//  FeedDetailsViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, novaResposta{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var comentarTextField: UITextField!
    //TableView
    @IBOutlet weak var detailsTableView : UITableView!
    
    //Dados das noticias, devemos usar para mandar para nossa TableView
    var passedCell: Dados!
    
    //Vetor com os comentarios
    var commentArray: [Answer] = []
    
    //Celula da noticia
    var newsCell : NewsDetailCell!
    
    var refreshControl : UIRefreshControl!
    
    
    let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    let tableBG = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1) //Cor do fundo apenas da tableview
    
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = false
        
        self.detailsTableView.registerNib(UINib(nibName: "DetalhesNoticiaCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        self.detailsTableView.registerNib(UINib(nibName: "ComentarioDetalhes", bundle: nil), forCellReuseIdentifier: "comentarioDetalhes")
        
        self.detailsTableView.reloadData()
        
        detailsTableView.estimatedRowHeight = 700
        detailsTableView.rowHeight = UITableViewAutomaticDimension
        /*
        self.detailsTableView.estimatedRowHeight = 500
        self.detailsTableView.rowHeight = UITableViewAutomaticDimension
        */
        /*
        image.image = passedCell.imagem
        fullText.text = passedCell.fulltext
        subTitle.text = passedCell.subtitulo
        navigationBarTitle.topItem?.title = passedCell.titulo
        
        fullText.layer.cornerRadius = 15
        fullText.layer.borderWidth = 3
        */
        
        self.detailsTableView.separatorStyle = .SingleLine
        
        configRefresh()
        
        pegarComentarios()
        
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
            
            passedCell.imagem?.getDataInBackgroundWithBlock({ (result, error) -> Void in
                
                cell.imagem.image = UIImage(data: result!)
                
            })
            cell.categoriaTitle.text = self.passedCell.titulo
            cell.subTitle.text = self.passedCell.subtitulo
            cell.fullText.text = self.passedCell.fulltext
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
    
        
        performSegueWithIdentifier("criarComentário", sender: self)

        self.comentarTextField.endEditing(true)
        
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
}
