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
    
    @IBOutlet weak var titulo: UINavigationItem!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aumentaLetra: UIButton!
    @IBOutlet weak var imagemCurso: UIImageView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let fontSize:[CGFloat] = [17.0, 20.0, 23.0]
    
    var actualFontSize:Int = 0
    
    var course : String!       //Celula passada pela segue, iremos pegar as informacoes para editar a pagina

    var universidade = [String]()
    
    override func viewWillDisappear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.layer.cornerRadius = 8

        self.automaticallyAdjustsScrollViewInsets = false
//        self.view.backgroundColor = passedCell.backgroundColor
//        self.titulo.title = passedCell.textLabel?.text
//        self.texto.text = passedCell.descricao
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findMateria(course) { (object, error) -> Void in
            
            if error == nil{
            
                self.titulo.title = object?.curso
                self.texto.text = object?.descricao
                self.texto.textColor = UIColor.blackColor()
                self.UniversidadeButton.titleLabel?.textColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1)
                self.universidade = (object?.universidades)!
                self.activityIndicator.stopAnimating()
            }
        }
        
        self.texto.numberOfLines = 0
        
        self.texto.font = UIFont(name: "Futura", size: 17.0)
        
        configButtons()
        
    }
    
    //Celula passada pela view com as materias é recebida por esse metodo
    func receiveCellData(cell: String) {
        self.course = cell;
      
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        //Como o texto e o icone a celula.
        let secondViewController = segue.destinationViewController as! UniversidadeTableViewController
        
        secondViewController.receiveCellData(self.universidade, course: self.course)
        
    }
    
    func configButtons(){
        
        self.aumentaLetra.addTarget(self, action: "aumentaLetra:", forControlEvents: .TouchUpInside)
        self.aumentaLetra.tintColor = UIColor.whiteColor()
        
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
    
    
}





