//
//  MateriasTableViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/20/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class MateriasTableViewController: UITableViewController {
    
    //Classes com dados em hardcode que serão utilizados para popular o aplicativo
    var materias : [String] = []

    //Celula que será selecionada e passada para a proxima view
    //var chosenCell : MateriaTableViewCell!
    
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setando o navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1.0) ]
        
        //setando a tableview
        
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        ParseModel.findAllMaterias { (array, error) -> Void in
            if error == nil{
                self.materias = array!
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return materias.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Materia", forIndexPath: indexPath) as! MateriaTableViewCell

        let cell = tableView.dequeueReusableCellWithIdentifier("Materia", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.materias[indexPath.row]
        
        
//        let materia = materias[indexPath.row] as Materia
//        
//        //Descrição da materia que sera passada para a próxima view
//        cell.descricao = materia.description
//        
//        //Lista de Universdades que possuem os cursos
//        cell.Universidades = materia.Universidades
//        
//        //Lista com grade horária das materias daquele curso
//        cell.Semestres = [materia.Semestre1,materia.Semestre2,materia.Semestre3]
//        
//        //Configuração da celula de materias
//        cell.textLabel?.text = materia.name
//        cell.imageView?.image = UIImage(named: materia.icon)
//        cell.backgroundColor = materia.color
//        
//        //cell.backgroundColor = UIColor.blackColor()
//        //cell.textLabel?.textColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
//
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        Quando a celula é selecionada ela chama a próxima view com o Detalhe das materias
//        self.chosenCell = self.tableView.cellForRowAtIndexPath(indexPath) as! MateriaTableViewCell
//        self.performSegueWithIdentifier("Detalhe", sender: self)
        
        self.index = indexPath.row
        self.performSegueWithIdentifier("Detalhe", sender: self)
        
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        //Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        //Como o texto e o icone a celula.
        let secondViewController = segue.destinationViewController as! MateriasDetalheViewController
        
        let course = self.materias[self.index]
        
        secondViewController.receiveCellData(course);
        
        
        
    }
    

}
