//
//  FeedTableViewController.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var data : [Dados] = []
    
    @IBOutlet weak var searchView: UIView!
    
    var dadosFiltrados = [Dados]()
    
    var resultSearchController = UISearchController()
    
    
    var chosenCell: Dados?
    
    override func viewWillAppear(animated: Bool) {
       // self.navigationController?.navigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createData()
        self.tableView.separatorColor = UIColor.clearColor()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        self.setNeedsStatusBarAppearanceUpdate()
        //self.navigationController?.navigationBarHidden = true
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.obscuresBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
        
        if self.resultSearchController.active{
            return dadosFiltrados.count
        }
        
        else{
            return data.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCard", forIndexPath: indexPath) as! FeedCell
        
        let info: Dados
        
        if self.resultSearchController.active{
        
            info = dadosFiltrados[indexPath.row] as Dados
            
        }
        else{
        
            if self.segmentedControl.selectedSegmentIndex == 0{
                
                info = data[indexPath.row] as Dados
                
            }
        
            else{
                
                let arrayCurtido: [Dados] = data.sort{$0.upvote > $1.upvote}
                info = arrayCurtido[indexPath.row] as Dados
                
                
            }
        }
        cell.upvoteCount.text = "\(String(info.upvote!))"
        cell.title.text = info.titulo
        cell.subTitle.text = info.subtitulo
        cell.textField.text = info.texto
        cell.picture.image = info.imagem
        cell.fullText = info.fulltext
        
        
        cell.cardSetup()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.GoToDetail(indexPath.row)
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        let secondViewController = segue.destinationViewController as! FeedDetailsViewController
        
        let cell = self.chosenCell
        
        secondViewController.receiveCellData(cell!);
        
    }
    
    
    func createData()
    {
        self.data.append(Dados(titulo: "Jornalismo", subtitulo: "Altas aventuras", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "Jtest"),upvote: 1042,fulltext:"texto inteiro de jornalismo"))
        
        self.data.append(Dados(titulo: "Economia", subtitulo: "Dólar em alta", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "Etest"), upvote: 12,fulltext:"texto inteiro de economia"))
        
        self.data.append(Dados(titulo: "Computação", subtitulo: "Mercado em Alta", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "Ctest"),upvote: 69,fulltext:"texto inteiro de computacao"))
        
        self.data.append(Dados(titulo: "Jornalismo", subtitulo: "Altas aventuras", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "Jtest"),upvote: 1042,fulltext:"texto inteiro de jornalismo"))
        
        self.data.append(Dados(titulo: "Economia", subtitulo: "Dólar em alta", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "Etest"), upvote: 12,fulltext:"texto inteiro de economia"))
        
        self.data.append(Dados(titulo: "Computação", subtitulo: "Mercado em Alta", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "Ctest"),upvote: 69,fulltext:"texto inteiro de computacao"))
        
        self.data.append(Dados(titulo: "Jornalismo", subtitulo: "Altas aventuras", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "Jtest"),upvote: 1042,fulltext:"texto inteiro de jornalismo"))
        
        self.data.append(Dados(titulo: "Economia", subtitulo: "Dólar em alta", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "Etest"), upvote: 12,fulltext:"texto inteiro de economia"))
        
        self.data.append(Dados(titulo: "Computação", subtitulo: "Mercado em Alta", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "Ctest"),upvote: 69,fulltext:"texto inteiro de computacao"))
        
        self.data.append(Dados(titulo: "Jornalismo", subtitulo: "Altas aventuras", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "Jtest"),upvote: 1042,fulltext:"texto inteiro de jornalismo"))
        
        self.data.append(Dados(titulo: "Economia", subtitulo: "Dólar em alta", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "Etest"), upvote: 12,fulltext:"texto inteiro de economia"))
        
        self.data.append(Dados(titulo: "Computação", subtitulo: "Mercado em Alta", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "Ctest"),upvote: 69,fulltext:"texto inteiro de computacao"))
        
        
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
    
    //MARK: - Métodos para o search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.dadosFiltrados.removeAll(keepCapacity: false)
        
        self.dadosFiltrados = self.data.filter({ (Dados:Dados) -> Bool in
            let stringMatch = Dados.subtitulo!.rangeOfString(searchController.searchBar.text!)
            return (stringMatch != nil)
        })
        
        
        self.tableView.reloadData()
        
    }
    
    @IBAction func searchDisplay(sender: AnyObject) {
        
        self.resultSearchController.becomeFirstResponder()
        
    }
    
    func presentSearchController(searchController: UISearchController) {
    }
    
    // MARK:- Metodos para upvoted
    
     func GoToDetail(sender: Int) {
       
        if self.resultSearchController.active{
            
            self.chosenCell = dadosFiltrados[sender] as Dados
            
        }
        else{
            
            if self.segmentedControl.selectedSegmentIndex == 0{
                
                self.chosenCell = data[sender] as Dados
                
            }
                
            else{
                
                let arrayCurtido: [Dados] = data.sort{$0.upvote > $1.upvote}
                self.chosenCell = arrayCurtido[sender] as Dados
                
                
            }
        
        }
        
        performSegueWithIdentifier("detalhesNoticia", sender: self)
        
        
        
    }
    
    
    //MARK:- Metodos do segmented control
    
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        
        self.tableView.reloadData()
        
    }
    
    
}



