//
//  MateriasTableViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/20/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class MateriasTableViewController: UITableViewController {

    var materias : [Materia] = []
    
    var chosenCell : MateriaTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setando o navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1.0) ]
        
        //setando a tableview
        
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
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
        cell.descricao = materia.description
        cell.Universidades = materia.Universidades
        cell.Semestres = [materia.Semestre1,materia.Semestre2,materia.Semestre3]
        cell.textLabel?.text = materia.name
        cell.imageView?.image = UIImage(named: materia.icon)
        cell.backgroundColor = materia.color
        
        //cell.backgroundColor = UIColor.blackColor()
        //cell.textLabel?.textColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
