//
//  FeedTableViewController.swift
//  FeedTest
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    let bgColor = UIColor(red: 27/255, green: 55/255, blue: 76/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    let tableBG = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //Cor do fundo apenas da tableview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createData()
        
        self.configRefresh()
        
        self.tableView.reloadData()
        
        self.nightMode = false
                
        self.refreshColors()
        
    }
    
    //Funcao que usaremos para eventualmente implementar metodo de leitura noturna, talvez
    //nao precisemos mais
    @IBAction func setNightMode(sender: AnyObject) {
    
     self.nightMode = !self.nightMode
        
     print(self.nightMode)
    
     self.tableView.reloadData()

    }
    
    //Esta funcao seta todas as cores da view, é usada como redundancia ao storyboard para que tenhamos
    //total controle sobre elas
    func refreshColors()
    {
       
        //Set the colors of the view
        self.view.backgroundColor = bgColor;
        self.tableView.separatorColor = detailsColor
        
        //Set the color of the navigation view background
        self.navigationController?.navigationBar.barTintColor = bgColor
        self.segmentedControl.backgroundColor = bgColor
        self.segmentedControl.tintColor = detailsColor
        
        //Change Status Bar Color
        self.setNeedsStatusBarAppearanceUpdate()
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
        cell.upvotes.text = "☆ " + String(info.upvote!)
        cell.subTitle.text = info.titulo
        cell.title.adjustsFontSizeToFitWidth = true
        cell.title.text = info.subtitulo!
        cell.subTitle.adjustsFontSizeToFitWidth = true
        cell.textField.text = info.texto
        cell.subTitle.adjustsFontSizeToFitWidth = true
        
//        info.imagem?.getDataInBackgroundWithBlock({ (result, error) -> Void in
//            
//            cell.picture.image = UIImage(data: result!)
//            
//        })
        
        cell.picture.image = info.imagem
        
        cell.fullText = info.fulltext
        
        cell.cardSetup()
        
        return cell
    }
    
    //Este tamanho de celula é hardcoded, pois a priori todas as celulas tem o mesmo tamanho, deve ser mudado
    //caso precisemos colocar um tamanho dinamico nas celulas
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
       
        if segue.identifier == "detalhesNoticia" {
            if let destination = segue.destinationViewController as? FeedDetailsViewController {
                destination.passedCell = self.chosenCell
            }
        }
    }
    
    //Essa funcao cria dados hardcoded para que possamos testar o layout da tableview
    func createData()
    {
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findAllNews({ (array, error) -> Void in
            
            if error == nil{
                self.data = array!
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.refreshControl!.endRefreshing()
            }
        })
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
        
        self.createData()
        self.refreshControl?.endRefreshing()
    }
    
    
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
        customSearchController.customSearchBar.placeholder = "Procure"
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
        
        self.dadosFiltrados = self.data.filter({ (Dados) -> Bool in
            let titleMatch: NSString = Dados.titulo!
            
            if (titleMatch.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound{
                return true
            }
            
            else{
                
                let tagMatch: NSString = Dados.subtitulo!
                
                return (tagMatch.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
                
            }
        })
        
        // Reload the tableview.
        self.tableView.reloadData()
    }
    
    //MARK:- Metodos do segmented control
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    
    
    //MARK: - Metodos para carregar mais
    
    let threshold: CGFloat = -10.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            self.isLoadingMore = true
            
            getMoreNews()
        }
    }
    
    func getMoreNews(){
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findMoreNews(self.data.count) { (array, error) -> Void in
            
            if error == nil {
                
                if let array = array {
                    
                    self.data = self.data + array
                    self.tableView.reloadData()
                    self.isLoadingMore = false
                    
                }
                
            }
            
            self.activityIndicator.stopAnimating()
            
        }
    
    }
    
    
}



