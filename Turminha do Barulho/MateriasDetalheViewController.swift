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
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var aumentaLetra: UIButton!
    @IBOutlet weak var modoNoturno: UIButton!
    
    var isModoNoturno:Bool = false
    
    let fontSize:[CGFloat] = [17.0, 20.0, 23.0]
    
    var actualFontSize:Int = 0
    
    var passedCell : MateriaTableViewCell!       //Celula passada pela segue, iremos pegar as informacoes para editar a pagina

    override func viewWillDisappear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.layer.cornerRadius = 8

        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = passedCell.backgroundColor
        self.titulo.title = passedCell.textLabel?.text
        self.texto.text = passedCell.descricao
        self.texto.numberOfLines = 0
        
        self.texto.font = UIFont(name: "Futura", size: 17.0)
        
        configButtons()
        
    }
    
    //Celula passada pela view com as materias é recebida por esse metodo
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
        
        self.aumentaLetra.addTarget(self, action: "aumentaLetra:", forControlEvents: .TouchUpInside)
        self.modoNoturno.addTarget(self, action: "modoNoturno:", forControlEvents: .TouchUpInside)
        
    }
    
    func aumentaLetra(sender: AnyObject){
        
        let size = self.actualFontSize + 1
        
        if size < self.fontSize.count{
            
            self.texto.font = UIFont(name: "Futura", size: self.fontSize[size])
            self.actualFontSize = size
        
        }
        else{
            
            self.texto.font = UIFont(name: "Futura", size: self.fontSize[0])
            self.actualFontSize = 0
            
        }
    }
    
    func modoNoturno(sender: AnyObject){
        
        if isModoNoturno{
            
            self.texto.textColor = UIColor.blackColor()
            self.scrollView.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor.whiteColor()
            
            self.isModoNoturno = false

            
        }
        else{
            
            self.texto.textColor = UIColor.whiteColor()
            self.scrollView.backgroundColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor.blackColor()
            
            self.isModoNoturno = true
        }
    }
    
}





