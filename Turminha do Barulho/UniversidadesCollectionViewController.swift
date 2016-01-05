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

    var passedData : CursoInfo!
//    var Semestre : [[String]] = [["Semestre 1","Calculo 1","GA","Calculo 3"],["Semestre 1","Calculo 1","GA","Calculo 3"],["Semestre 1","Calculo 1","GA","Introducao a Engenhariaasjdashdafabnbzncjkabsbchabchbdchbjnaslkjdkas;lkcakskcnjadndkhcabdjcndjsbkcbakjbdcasd"]]
//    var numSemestre : Int = 0
    
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    @IBOutlet var UniversidadeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.UniversidadeCollectionView.registerClass(DescricaoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier1)
//        self.UniversidadeCollectionView.registerClass(MateriaCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier2)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveCellData(data: CursoInfo) {
        
        self.passedData = data;
        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return passedData.semestres!.count + 1
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
                headerView.header.text = "Semestre " + String(indexPath.section)
                return headerView
            }
            
        default:
            assert(false, "Unexpected element kind")
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if (indexPath.section == 0){
            let cellDescricao = UniversidadeCollectionView.dequeueReusableCellWithReuseIdentifier("Descricao", forIndexPath: indexPath) as! DescricaoCollectionViewCell
            let legal = "É mais legalasxajskcndakbcakhsbvajvfahdfbvhadfbabivubverbaiuebjsbdkbafkhvbafhkbdbfhkvdbvfhkadbvkadhbvrubkvahbkhvfbdhkvabdkhfhkbvfadhbvkdbfhvbadfhkveofefjjfjfd"
            cellDescricao.descricaoLabel.text = legal
            cellDescricao.descricaoLabel.sizeToFit()
            return cellDescricao
        }
        else{
            let cellMateria = collectionView.dequeueReusableCellWithReuseIdentifier("Materia", forIndexPath: indexPath) as! MateriaCollectionViewCell
            cellMateria.materiaSemestre.adjustsFontSizeToFitWidth = true
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
        
        if (indexPath.section == 0){
            return CGSize(width: 400, height: 200)
        }
        else{
            return CGSize(width: 100, height: 100)
        }
        
    }
        
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }

}
