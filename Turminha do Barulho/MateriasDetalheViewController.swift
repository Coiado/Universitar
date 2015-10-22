//
//  MateriasDetalheViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 22/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class MateriasDetalheViewController: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var texto: UITextView!
    
    var passedCell : UITableViewCell!       //Celula passada pela segue, iremos pegar as informacoes para editar a pagina
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = passedCell.backgroundColor
        self.titulo.text = passedCell.textLabel?.text
        self.texto.editable = false
        
    }
    
    func receiveCellData(cell: UITableViewCell) {
        self.passedCell = cell;
      
    }
    
}
