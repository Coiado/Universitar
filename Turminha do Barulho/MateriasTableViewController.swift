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
    var materias : [Materia] = []

    //Celula que será selecionada e passada para a proxima view
    var chosenCell : MateriaTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dados em hardcode sendo carregados de um arquivo plist
        materias = Materia.loadAllMateria()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Materia", forIndexPath: indexPath) as! MateriaTableViewCell
        
        let materia = materias[indexPath.row] as Materia
        
        //Descrição da materia que sera passada para a próxima view
        cell.descricao = materia.description
        
        //Lista de Universdades que possuem os cursos
        cell.Universidades = materia.Universidades
        
        //Lista com grade horária das materias daquele curso
        cell.Semestres = [materia.Semestre1,materia.Semestre2,materia.Semestre3]
        
        //Configuração da celula de materias
        cell.textLabel?.text = materia.name
        cell.imageView?.image = UIImage(named: materia.icon)
        cell.backgroundColor = materia.color

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Quando a celula é selecionada ela chama a próxima view com o Detalhe das materias
        self.chosenCell = self.tableView.cellForRowAtIndexPath(indexPath) as! MateriaTableViewCell
        self.performSegueWithIdentifier("Detalhe", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        //Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        //Como o texto e o icone a celula.
        let secondViewController = segue.destinationViewController as! MateriasDetalheViewController
        
        let cell = self.chosenCell
        
        secondViewController.receiveCellData(cell!);
        
        
        
    }
    

}
