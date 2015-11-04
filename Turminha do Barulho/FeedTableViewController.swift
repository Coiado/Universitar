//
//  FeedTableViewController.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var data : [Dados] = []
        
    var chosenCell: Dados?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createData()
        self.tableView.separatorColor = UIColor.clearColor()

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
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCard", forIndexPath: indexPath) as! FeedCell
        
        let info = data[indexPath.row] as Dados
        cell.upvoteCount.text = "\(String(info.upvote!)) Pontos"
        cell.title.text = info.titulo
        cell.subTitle.text = info.subtitulo
        cell.textField.text = info.texto
        cell.picture.image = info.imagem
        cell.fullText = info.fulltext
        
        //configurar botao para o upvote
        //cell.upvoteButton.addTarget(self, action: "Upvoted", forControlEvents: .TouchUpInside)
        cell.upvoteButton.tag = indexPath.row
        
        //cell.moreButton
        cell.moreButton.tag = indexPath.row
        
        cell.cardSetup()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        let secondViewController = segue.destinationViewController as! FeedDetailsViewController
        
        let cell = self.chosenCell
        
        secondViewController.receiveCellData(cell!);
        
    }
    
    
    func createData()
    {
        self.data.append(Dados(titulo: "Jornalismo", subtitulo: "Altas aventuras", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "JornalismoIcon"),upvote: 1042,fulltext:"texto inteiro de jornalismo"))
        
        self.data.append(Dados(titulo: "Economia", subtitulo: "Dólar em alta", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "EconomiaIcon"), upvote: 12,fulltext:"texto inteiro de economia"))
        
        self.data.append(Dados(titulo: "Computação", subtitulo: "Mercado em Alta", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "CompIcon"),upvote: 69,fulltext:"texto inteiro de computacao"))
        
        self.tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK:- Metodos para upvoted
    
    @IBAction func GoToDetail(sender: AnyObject) {
       
        let row = sender.tag
        self.chosenCell = data[row]
        
        performSegueWithIdentifier("detalhesNoticia", sender: self)
        
        
        
    }
    
    
    @IBAction func Upvoted(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        let row = sender.tag
        
        let cell = data[row]
        
        let upvotes:Int = data[row].upvote!
        
        if cell.upvoted == false {
            
            data[row].upvoted = true
            data[row].upvote = (upvotes + 1)
            button.backgroundColor = UIColor.init(red: 10/255, green: 96/255, blue: 254/255, alpha: 1.0)
        }
        else {
            
            data[row].upvoted = false
            data[row].upvote = upvotes - 1
            button.highlighted = false
            button.backgroundColor = UIColor.darkGrayColor()
        }
        
        //self.tableView.reloadData()
        
        let indexpath = NSIndexPath(forRow: row, inSection: 0)
        
        self.tableView.reloadRowsAtIndexPaths([indexpath] ,withRowAnimation: UITableViewRowAnimation.None)
    }
    
}



