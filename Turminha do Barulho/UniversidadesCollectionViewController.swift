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

    var passedCell : UniversidadeTableViewCell!
    var Semestre : NSMutableArray = [["Semestre 1","Calculo 1","GA","Calculo 3"],["Semestre 1","Calculo 1","GA","Calculo 3"],["Semestre 1","Calculo 1","GA","Introducao a Engenharia"]]
    var numSemestre : Int = 0
    
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
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
    
    func receiveCellData(cell: UniversidadeTableViewCell) {
        self.passedCell = cell;
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return passedCell.Semestres.count + 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if (section == 0){
            return 1
        }
        else{
            return self.Semestre[section-1].count
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
//        self.UniversidadeCollectionView.registerClass(DescricaoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier1)
//        self.UniversidadeCollectionView.registerClass(MateriaCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier2)
        if (indexPath.section == 0){
            let cellDescricao = UniversidadeCollectionView.dequeueReusableCellWithReuseIdentifier("Descricao", forIndexPath: indexPath) as! DescricaoCollectionViewCell
            let legal = "É mais legalasxajskcndakbcakhsbvajvfahdfbvhadfbabivubverbaiuebjsbdkbafkhvbafhkbdbfhkvdbvfhkadbvkadhbvrubkvahbkhvfbdhkvabdkhfhkbvfadhbvkdbfhvbadfhkveofefjjfjfd"
            cellDescricao.descricaoLabel.text = legal
            cellDescricao.descricaoLabel.sizeToFit()
            return cellDescricao
        }
        else{
            let cellMateria = collectionView.dequeueReusableCellWithReuseIdentifier("Materia", forIndexPath: indexPath) as! MateriaCollectionViewCell
            cellMateria.materiaSemestre.text = self.Semestre[indexPath.section-1] as? String
            return cellMateria
            
        }
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
            if (indexPath.section == 0){
                
                return CGSize(width: 400, height: 200)
            }
                return CGSize(width: 100, height: 100)
        }
        
        //3
        func collectionView(collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAtIndex section: Int) -> UIEdgeInsets {
                return sectionInsets
        }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
