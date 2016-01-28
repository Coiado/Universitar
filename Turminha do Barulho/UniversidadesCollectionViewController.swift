//
//  UniversidadesCollectionViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/12/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

private let reuseIdentifier1 = "Descricao"
private let reuseIdentifier2 = "Materia"

class UniversidadesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var navigationUniversidades: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var passedData : CursoInfo!
    
    var universidade : String?
    
    var heightDescricao : CGFloat?
    
    var curso: String?
    
    var tempLabel: UILabel = UILabel()
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    @IBOutlet var UniversidadeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempLabel.numberOfLines = 0 
        self.activityIndicator.startAnimating()
        
        ParseModel.findCourseInfos(self.curso!, universidade: self.universidade!) { (object, error) -> Void in
            
            if error == nil{
                
                self.passedData = object!
                self.collectionView?.reloadData()
                self.getSizeDescricao(self.passedData.descricaoUniversidade!)
                self.activityIndicator.stopAnimating()
                self.navigationUniversidades.title = object?.universidade
                
            }
            
        }
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveCellData(curso: String, universidade: String) {
        
        self.curso = curso
        self.universidade = universidade
        
    }
    
    //Calculando o tamanho da celula da descrição
    func getSizeDescricao(string: String){
        self.tempLabel = UILabel(frame: CGRectMake(0 , 0, self.view.frame.width, 70))
        self.tempLabel.numberOfLines = 0
        self.tempLabel.lineBreakMode = .ByWordWrapping
        self.tempLabel.text = string
        self.tempLabel.font = UIFont(name: "System", size: 17.0)
        let size = self.tempLabel.sizeThatFits(CGSize(width: (self.view.frame.width - 80), height: CGFloat.max))
//        self.tempLabel.sizeToFit()
        self.heightDescricao = size.height
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if let array = self.passedData{
            return array.semestres!.count + 1
        }
        else{
            return 0
        }
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if (section == 0){
            return 1
        }
        else{
            return self.passedData.semestres![section-1].count
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            if(indexPath.section == 0){
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! HeaderSemestreCollection
                headerView.header.text = "Descrição"
                return headerView
            }
            else{
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! HeaderSemestreCollection
                headerView.header.text =  String(indexPath.section ) + "º Semestre"
                return headerView
            }
            
        default:
            assert(false, "Unexpected element kind")
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! HeaderSemestreCollection
            headerView.header.text =  "º Semestre"
            return headerView
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (indexPath.section == 0){
            let cellDescricao = UniversidadeCollectionView.dequeueReusableCellWithReuseIdentifier("Descricao", forIndexPath: indexPath) as! DescricaoCollectionViewCell
            cellDescricao.descricaoLabel.text = self.passedData.descricaoUniversidade
//            cellDescricao.descricaoLabel.sizeToFit()
            cellDescricao.descricaoLabel.updateConstraints()
            cellDescricao.layer.cornerRadius = 15
            cellDescricao.contentView.layer.masksToBounds = true
            return cellDescricao
        }
        else{
            let cellMateria = collectionView.dequeueReusableCellWithReuseIdentifier("Materia", forIndexPath: indexPath) as! MateriaCollectionViewCell
            cellMateria.layer.masksToBounds = true
            cellMateria.layer.cornerRadius = 10.0
            cellMateria.contentView.layer.cornerRadius = 10.0
            cellMateria.contentView.layer.borderWidth = 1.0
            cellMateria.contentView.layer.masksToBounds = true
            cellMateria.materiaSemestre.text = self.passedData.semestres![indexPath.section-1][indexPath.row]
            cellMateria.contentMode = .Center
            cellMateria.updateConstraints()
            return cellMateria
            
        }
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //Altera o tamanho das celulas tanto headers quanto a descrição e as materias
        if (indexPath.section == 0){
            print ("self.heightDescricao! \(self.heightDescricao!)")
            return CGSize(width: self.view.frame.width - 20, height: self.heightDescricao! + 100)
        }
        else{
            return CGSize(width: 110, height: 60)
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section != 0){
            let cellMateria = collectionView.dequeueReusableCellWithReuseIdentifier("Materia", forIndexPath: indexPath) as! MateriaCollectionViewCell
            let detalhe = UIAlertController(title: self.passedData.semestres![indexPath.section-1][indexPath.row], message: "", preferredStyle: UIAlertControllerStyle.Alert)
            detalhe.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(detalhe, animated: true, completion: nil)
        }
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }

}
