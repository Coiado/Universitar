//
//  FeedTableViewController.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    var customSearchController: CustomSearchController!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var data : [Dados] = []
    
    var dadosFiltrados = [Dados]()
    
    var chosenCell: Dados?
    
    @IBOutlet weak var searchView: UIView!
    
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createData()
        
        self.view.backgroundColor = UIColor.whiteColor()//UIColor.blackColor()
        
        self.tableView.separatorColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        self.setNeedsStatusBarAppearanceUpdate()

        configureCustomSearchController()
        
        configRefresh()
        
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
        self.data.append(Dados(titulo: "Teste", subtitulo: "Jornalismo", texto: "Saiba mais sobre o jornalista que cobriu de perto o estado islamico", imagem: UIImage(named: "Jtest"),upvote: 1042,fulltext:"texto inteiro de jornalismo"))
        
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
    
    
    //MARK - Metodos para o refresh
    
    func configRefresh(){
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = UIColor.blackColor()
        self.refreshControl!.tintColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
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
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1), searchBarTintColor: UIColor.blackColor())
        
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



