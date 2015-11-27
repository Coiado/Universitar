//
//  FeedDetailsViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //TableView
    @IBOutlet weak var detailsTableView : UITableView!
    
    //Dados das noticias, devemos usar para mandar para nossa TableView
    var passedCell: FeedCell!
    
    //Vetor com os comentarios
    var commentArray: [AnswerTableViewCell] = []
    
    //Celula da noticia
    var newsCell : NewsDetailCell!
    
    var answers1 = [Answer(nickname: "Jorge", userIcon: UIImage(named: "userIcon"), answerText: "É bom sim! Gosto muito albdsbashcbdsbajdbakjbckadcbjsdcjdnsjkcbdscndnacbdsbckjbdsjcjnsdcjnsjkdcjkdsbchbshdbcajndcjbdskbcjdsabcjkasdjasdkjkadjaschasbcasbkcbaskhcbas"), Answer(nickname: "Joaquim", userIcon: UIImage(named: "userIcon"), answerText: "Não gosto")]
    
    
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = false
        
        self.detailsTableView.registerNib(UINib(nibName: "DetalhesNoticiaCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        
        
        self.detailsTableView.reloadData()
        detailsTableView.estimatedRowHeight = 700
        detailsTableView.rowHeight = UITableViewAutomaticDimension
        /*
        image.image = passedCell.imagem
        fullText.text = passedCell.fulltext
        subTitle.text = passedCell.subtitulo
        navigationBarTitle.topItem?.title = passedCell.titulo
        
        fullText.layer.cornerRadius = 15
        fullText.layer.borderWidth = 3
        */
        
    }
    
    
    func populateNewsDetails(cell: NewsDetailCell!)
    {
        cell.imagem.image = self.passedCell.picture.image
        cell.categoriaTitle.text = self.passedCell.title.text
        cell.subTitle.text = self.passedCell.subTitle.text
        cell.fullText.text = self.passedCell.fullText
        //Metodo de resolucao da celula, TO DO
    }
    
    func receiveCellData(cell: FeedCell) {
        self.passedCell = cell;
        
    }

    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
        
    }
    
    //TableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Noticia + comentarios
        return 1 + self.commentArray.count + self.answers1.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //Muda de identifier para identifier
        var height : CGFloat
        if (indexPath.row==0){
            height = 700.0
        }
        else{
            height = 150.0
        }
        return height;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Precisamos retornar uma celula de noticia caso seja a primeira celula ou celulas de comentarios
        if (indexPath.row==0){
            let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as! NewsDetailCell
            
            cell.imagem.image = self.passedCell.picture.image
            cell.categoriaTitle.text = self.passedCell.title.text
            cell.subTitle.text = self.passedCell.subTitle.text
            cell.fullText.text = self.passedCell.fullText
            cell.prepareCell()
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! AnswerTableViewCell
            let info = answers1[indexPath.row-1] as Answer
            cell.answerText.text = info.answerText
            cell.answerText.sizeToFit()
            cell.updateConstraints()
            cell.userIcon.image = info.userIcon
            cell.nickName.text = info.nickname
            cell.likes.text = String(15)
            cell.cardSetup()
            return cell //A priori
        }
    }
    
}
