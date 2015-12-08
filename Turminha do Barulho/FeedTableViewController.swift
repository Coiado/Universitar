//
//  FeedTableViewController.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    //TEMP
    let LOREM = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
    
    //Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet var segControl: UISegmentedControl!
    @IBOutlet weak var nightmodeButton: UIBarButtonItem!
    
    //Search controllers
    var customSearchController: CustomSearchController!
    var shouldShowSearchResults = false
    
    //Volume de dados
    var data : [Dados] = []
    var dadosFiltrados = [Dados]()
    var chosenCell: Dados?
    
    //Array de celulas, usamos para poder acessar toda as celulas de uma vez so
    var cellArray : [FeedCell] = []
    var nightMode : Bool!
    
    
    //QUANDO QUISER ALTERAR UMA COR ALTERE AQUI =)
    //Colors
    let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    let detailsColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1)
    let tableBG = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.createData()
        
        self.configRefresh()
        
        self.tableView.reloadData()
        
        self.nightMode = false
        
        self.refreshColors()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func setNightMode(sender: AnyObject) {
    
     self.nightMode = !self.nightMode
        
     print(self.nightMode)
    
     self.tableView.reloadData()

    }
    
    
    func refreshColors()
    {
        //Refresh colors, used on night mode
       
        //Set the colors of the view
        self.view.backgroundColor = bgColor;
        self.tableView.separatorColor = detailsColor
        
        //Set the color of the navigation view background
        self.navigationController?.navigationBar.barTintColor = bgColor
        self.segmentedControl.backgroundColor = bgColor
        self.segmentedControl.tintColor = detailsColor
        
        //Change Status Bar Color
        self.setNeedsStatusBarAppearanceUpdate()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        //Configure the custom search controller
        configureCustomSearchController()
        
        //TableView Background
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = tableBG
       

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.shouldShowSearchResults{
            return dadosFiltrados.count
        }
        
        else{
            return data.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCard", forIndexPath: indexPath) as! FeedCell
        
        let info: Dados
        
        if self.shouldShowSearchResults{
        
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
        cell.subTitle.text = info.subtitulo!
        cell.textField.text = info.texto
        cell.picture.image = info.imagem
        cell.fullText = info.fulltext
        
        
        cell.cardSetup()
        
        
        //self.refreshColors()
        if(self.nightMode == true)
        {
            cell.setColors()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.GoToDetail(indexPath.row)
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.4
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        //        let secondViewController = segue.destinationViewController as! FeedDetailsViewController
        //
        //        let cell = self.chosenCell
        //
        //        secondViewController.receiveCellData(cell!);
       
        if segue.identifier == "detalhesNoticia" {
            if let destination = segue.destinationViewController as? FeedDetailsViewController {
                let path = self.tableView?.indexPathForSelectedRow!
                let cell = self.tableView!.cellForRowAtIndexPath(path!) as! FeedCell
                destination.passedCell = cell
            }
        }
    }
    

    func createData()
    {
        self.data.append(Dados(titulo: "Altas Aventuras", subtitulo: "Jornalismo", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "Jtest"),upvote: 1042,fulltext:LOREM))
        
        self.data.append(Dados(titulo: "Dólar em Alta", subtitulo: "Economia", texto: "Dólar subiu? Bolsa quebrou? Saiba como um economista influencia essa área", imagem: UIImage(named: "Etest"), upvote: 12,fulltext:LOREM))
        
        self.data.append(Dados(titulo: "Mercado em Alta", subtitulo: "Computação", texto: "Busca por profissionais na área de TI aumenta 78%", imagem: UIImage(named: "Ctest"),upvote: 69,fulltext:LOREM))
        
       
        
        
        self.tableView.reloadData()
    }
    
    
    //MARK - Metodos para o refresh
    
    func configRefresh(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = bgColor
        self.refreshControl!.tintColor = detailsColor
        self.refreshControl!.addTarget(self, action: "refreshTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
    }
    
    func refreshTableView(sender: AnyObject){
        
        print("refresh")
        
        self.tableView.reloadData()
        
        self.refreshControl!.endRefreshing()
        
    }
    
    // MARK:- Metodos para upvoted
    
     func GoToDetail(sender: Int) {
       
        if self.shouldShowSearchResults{
            
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
    
    //MARK: - SearchController
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: detailsColor, searchBarTintColor: bgColor)
        
        customSearchController.searchBar.searchBarStyle = UISearchBarStyle.Default
        customSearchController.customSearchBar.placeholder = "Search in this awesome bar..."
        self.tableView.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
        
    }
    
    func didStartSearching() {
        shouldShowSearchResults = true
        self.tableView.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        self.dadosFiltrados = self.data.filter({ (Dados) -> Bool in
            let stringMatch: NSString = Dados.titulo!
            
            return (stringMatch.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        self.tableView.reloadData()
    }
    
    //MARK:- Metodos do segmented control
    
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        
        self.tableView.reloadData()
        
    }
    
    
}



