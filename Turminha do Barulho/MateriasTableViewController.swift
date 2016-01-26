//
//  MateriasTableViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/20/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class MateriasTableViewController: UITableViewController {
    
    //variaveis para o search bar
    var materiasFiltradas = [String]()
    
    var resultSearchController = UISearchController()
    
    //Classes com dados em hardcode que serão utilizados para popular o aplicativo
    var materias : [String] = []

    //Celula que será selecionada e passada para a proxima view
    //var chosenCell : MateriaTableViewCell!
    
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.scopeButtonTitles = ["Todos", "Exatas", "Humanas", "Biológicas"]
            controller.searchBar.delegate = self
            definesPresentationContext = true
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
            
        })()
        
        //setando o navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 21/255, green: 41/255, blue: 60/255, alpha: 1)  //Cor de fundo

        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0) ]
        
        //setando a tableview
        //self.tableView.backgroundColor = UIColor.whiteColor()
        //self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        
        
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
        if (self.resultSearchController.active && self.resultSearchController.searchBar.text != ""){
            return materiasFiltradas.count
        }
        else{
            
            return materias.count
            
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Materia", forIndexPath: indexPath) as! MateriaTableViewCell

        let cell = tableView.dequeueReusableCellWithIdentifier("Materia", forIndexPath: indexPath) as UITableViewCell
        
        let index = indexPath.row
        
        let materia: String
        
        if self.resultSearchController.active && self.resultSearchController.searchBar.text != "" {
            
            materia = self.materiasFiltradas[index]
            
        }
        else{
            materia = self.materias[index]
        
        }
        
        cell.textLabel?.text = materia
        cell.detailTextLabel?.text = "Exatas"
        
        return cell
        
        }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        Quando a celula é selecionada ela chama a próxima view com o Detalhe das materias
        
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
        if self.resultSearchController.active && self.resultSearchController.searchBar.text != ""{
            
            let course = self.materiasFiltradas[self.index]
            
            secondViewController.receiveCellData(course)
            
        }
        else{
            let course = self.materias[self.index]
            
            secondViewController.receiveCellData(course);
        }
        
    }
    
    
    //MARK: - Update func
    
    func filtrarDados(searchText: String, scope: String = "All"){
        
        self.materiasFiltradas = self.materias.filter({ (materia) -> Bool in
            
            //let categoryMatch = (scope == "All") || (materia.category == scope)
            
            return materia.lowercaseString.containsString(searchText.lowercaseString) //&& categoryMatch
            
        })
        
        self.tableView.reloadData()
        
    }
    
}

extension MateriasTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchBarText = searchController.searchBar.text!
        
        let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        
        filtrarDados(searchBarText, scope: scope)
        
    }
}

extension MateriasTableViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        let searchBarText = searchBar.text!
        
        let scope = searchBar.scopeButtonTitles![selectedScope]
        
        filtrarDados(searchBarText, scope: scope )
        
    }
    
}

