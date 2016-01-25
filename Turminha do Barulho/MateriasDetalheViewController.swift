//
//  MateriasDetalheViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 22/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class MateriasDetalheViewController: UIViewController {

    @IBOutlet weak var UniversidadeButton: UIButton!
    
    @IBOutlet weak var tituloEngenharia: UILabel!
    @IBOutlet weak var titulo: UINavigationItem!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aumentaLetra: UIButton!
    @IBOutlet weak var imagemCurso: UIImageView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let squareOrigin : CGPoint = CGPoint(x: -10, y: -10)
    
    @IBOutlet weak var activityIndicatorImagem: UIActivityIndicatorView!
    
    
    //let charNumber = (self.categoriaTitle.text?.characters.count)!*8
    let squareSize : CGSize = CGSize(width: 240, height: 40)
    
    var isModoNoturno:Bool = false
    
    let fontSize:[CGFloat] = [17.0, 20.0, 23.0]
    
    var actualFontSize:Int = 0
    
    var course : String!       //Celula passada pela segue, iremos pegar as informacoes para editar a pagina

    var universidade = [String]()
    
    
    override func viewWillAppear(animated: Bool) {
        self.UniversidadeButton.titleLabel?.textColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.UniversidadeButton.enabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.layer.cornerRadius = 8
        
        self.UniversidadeButton.enabled = false

        self.automaticallyAdjustsScrollViewInsets = false
//        self.view.backgroundColor = passedCell.backgroundColor
//        self.titulo.title = passedCell.textLabel?.text
//        self.texto.text = passedCell.descricao
        
        ParseModel.findMateria(course) { (object, error) -> Void in
            
            if error == nil{
            
                self.texto.text = object?.descricao
                self.texto.textColor = UIColor.blackColor()
                self.UniversidadeButton.backgroundColor = UIColor(red: 255/255, green: 89/255, blue: 72/255, alpha: 1)
                self.UniversidadeButton.layer.cornerRadius = 5
                self.UniversidadeButton.titleLabel?.textColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
                self.universidade = (object?.universidades)!
                let whiteSquare : UIView = UIView(frame: CGRect(origin: self.squareOrigin, size: self.squareSize))
                self.tituloEngenharia.text = object?.curso
                whiteSquare.layer.cornerRadius = 10
                whiteSquare.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                whiteSquare.alpha = 0.8
                self.imagemCurso.addSubview(whiteSquare)
                self.imagemCurso.bringSubviewToFront(self.tituloEngenharia)
                self.activityIndicator.startAnimating()
                self.activityIndicator.stopAnimating()
                self.activityIndicatorImagem.startAnimating()
                
                let file = object?.file
                
                file?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    
                    if error == nil {
                        
                        self.imagemCurso.image = UIImage(data: data!)
                        
                        
                        
                    }
                    self.activityIndicatorImagem.stopAnimating()
                })
                
            }
            
            
            
        }
        
        
        
        self.texto.numberOfLines = 0
        
        //self.texto.font = UIFont(name: "Futura", size: 17.0)
        
        configButtons()
        
        self.UniversidadeButton.titleLabel?.textColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1)
        
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





