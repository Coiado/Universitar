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
    var passedCell: Dados!
    
    //Vetor com os comentarios
    var commentArray: [AnswerTableViewCell] = []
    
    //Celula da noticia
    var newsCell : NewsDetailCell!
    

    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = false
        
        self.detailsTableView.registerNib(UINib(nibName: "DetalhesNoticiaCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        
        
        self.detailsTableView.reloadData()
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
        cell.imagem.image = self.passedCell.imagem
        cell.categoriaTitle.text = self.passedCell.titulo
        cell.subTitle.text = self.passedCell.subtitulo
        cell.fullText.text = self.passedCell.fulltext
        //Metodo de resolucao da celula, TO DO
    }
    
    func receiveCellData(cell: Dados) {
        self.passedCell = cell;
        
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

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //Muda de identifier para identifier

        return 700;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Precisamos retornar uma celula de noticia caso seja a primeira celula ou celulas de comentarios
        let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as! NewsDetailCell
        
        cell.imagem.image = self.passedCell.imagem
        cell.categoriaTitle.text = self.passedCell.titulo
        cell.subTitle.text = self.passedCell.subtitulo
        cell.fullText.text = self.passedCell.fulltext
        
        cell.prepareCell()
        
        
        return cell //A priori
    }
    
}
