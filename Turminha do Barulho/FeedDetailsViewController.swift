//
//  FeedDetailsViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var navigationBarTitle: UINavigationBar!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var fullText: UITextView!
    
    var passedCell: Dados!
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = false
        
        image.image = passedCell.imagem
        fullText.text = passedCell.fulltext
        subTitle.text = passedCell.subtitulo
        navigationBarTitle.topItem?.title = passedCell.titulo
        
        fullText.layer.cornerRadius = 15
        fullText.layer.borderWidth = 3
        
    }
    
    
    func receiveCellData(cell: Dados) {
        self.passedCell = cell;
        
    }

    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
        
    }
    
    
    
    
}
