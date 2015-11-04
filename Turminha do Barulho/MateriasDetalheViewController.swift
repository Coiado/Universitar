//
//  MateriasDetalheViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 22/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class MateriasDetalheViewController: UIViewController {

    @IBOutlet weak var UniversidadeButton: UIButton!
    @IBOutlet weak var FeedButton: UIButton!
    
    @IBOutlet weak var titulo: UINavigationItem!
    @IBOutlet weak var texto: UITextView!
    
    var passedCell : MateriaTableViewCell!       //Celula passada pela segue, iremos pegar as informacoes para editar a pagina
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.layer.cornerRadius = 8

        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = passedCell.backgroundColor
        self.titulo.title = passedCell.textLabel?.text
        self.texto.text = passedCell.descricao
        self.texto.editable = false
        
        configButtons()
        
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
    
    @IBAction func feedMateria(sender: AnyObject) {
        let alert = UIAlertView (title: "Invalido", message: "Em construção, estamos finalizando", delegate: self, cancelButtonTitle: "Ok")
        alert.show()
    }
    
    func configButtons(){
        
        UniversidadeButton.layer.cornerRadius = 10
        FeedButton.layer.cornerRadius = 10
        
    }
    
    
}





