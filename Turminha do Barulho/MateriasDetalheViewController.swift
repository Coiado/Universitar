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
    
    var passedCell : MateriaTableViewCell!       //Celula passada pela segue, iremos pegar as informacoes para editar a pagina
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.texto.layer.cornerRadius = 8
        self.titulo.layer.cornerRadius = 15
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = passedCell.backgroundColor
        self.titulo.text = passedCell.textLabel?.text
        self.texto.text = passedCell.descricao
        self.texto.editable = false
        
    }
    
    func receiveCellData(cell: MateriaTableViewCell) {
        self.passedCell = cell;
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        //Como o texto e o icone a celula.
        let secondViewController = segue.destinationViewController as! UniversidadeTableViewController
        
        let cell = passedCell
        
        
        secondViewController.receiveCellData(cell!);
        
        
        
    }
}
