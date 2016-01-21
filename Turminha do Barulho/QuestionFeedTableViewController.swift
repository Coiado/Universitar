//
//  QuestionFeedTableViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

protocol novaPergunta {
    func salvarNovaPergunta(titleText:String, doubtText:String)
}

class QuestionFeedTableViewController: UITableViewController, UITextFieldDelegate,UITextViewDelegate, novaPergunta {

    @IBOutlet weak var pergunteButton: UIButton!
    
    // teste
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var question : [Question] = []
    
    var chosenCell : QuestionFeedCell!
    

    var imagesDictionary = [String:UIImage]()
    
    
    // Cores que serao usadas para colorir o fundo da tableview
    let tableBG = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.getQuestion()
        
        configureButton()
        
        configRefresh()
        
        //self.tableView.separatorColor = UIColor.clearColor()
        //let backItem = UIBarButtonItem(title: "Voltar", style: .Bordered, target: nil, action: nil)
        //navigationItem.backBarButtonItem = backItem
        
        // Mudanca na coloracao da navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 27/255, green: 55/255, blue: 76/255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1.0) ]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.backgroundColor = tableBG
        self.tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        self.imagesDictionary.removeAll()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Refresh
    
    let bgColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    func configRefresh(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = bgColor
        self.refreshControl!.tintColor = detailsColor
        self.refreshControl!.addTarget(self, action: "refreshTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
    }
    
    func refreshTableView(sender: AnyObject){
        
        self.getQuestion()
        self.imagesDictionary = [:]
        self.refreshControl!.endRefreshing()
    }
    
    
    func configureButton(){
        
        self.pergunteButton.addTarget(self, action: "fazerPergunta", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
    func fazerPergunta(){
        let user = PFUser.currentUser()?.objectId
        if user == nil{
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else{
            self.performSegueWithIdentifier("criarPergunta", sender: self)
        }
        
        
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return question.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("questionFeedCell", forIndexPath: indexPath) as! QuestionFeedCell

        let info = question[indexPath.row] as Question
        cell.perguntaTitulo.text = info.questionTitle
        
        let file = String(info.userIcon)
        
        if let image = self.imagesDictionary[file]{
        
            cell.userIcon.image = image
        
        }
        else{
            
            if let file = info.userIcon {
                ParseModel.getImage(file, completionHandler: { (data, error, file) -> Void in
                    
                    if error == nil {
                        
                        let image = UIImage(data: data!)
                        let file = String(info.userIcon)
                        cell.userIcon.image = image
                        self.imagesDictionary[file] = image
                        
                    }
                    
                })
            
            }
            else{
                
                cell.userIcon.image = UIImage(named: "userIcon")
                
            }
        }
        
        cell.userIcon.layer.cornerRadius = 15
        cell.userIcon.layer.masksToBounds = true
        cell.nickName.text = info.nickname
        cell.questionText.text = info.questionText
        
        // Fazendo com que o texto fique adaptavel com a celula da tableview
        cell.questionText.sizeToFit()
        cell.updateConstraints()
        cell.cardSetup()
        
        let now = NSDate()
        
        cell.dateLabel.text = now.offsetFrom(info.date)
        
        // Deixando a foto do perfil arredondada
        cell.userIcon.layer.cornerRadius = cell.userIcon.frame.width/2
        
        return cell
        
        // Codigo para deixar um gradiente de cor numa celula do question Feed
        /*
        if (indexPath.row)%2 == 0{
            
            let color = UIColor.init(red: 177/255, green: 237/255, blue: 232/255, alpha: 1.0)
            let textColor = UIColor.init(red: 255/255, green: 105/255, blue: 120/255, alpha: 1.0)
            let colorBottom = UIColor.whiteColor().CGColor
            
            //let color = UIColor.init(red: 215/255, green: 217/255, blue: 206/255, alpha: 1).CGColor
            
            let gl = CAGradientLayer()
            
            gl.colors = [colorBottom, color.CGColor, colorBottom]
            gl.locations = [0.0,1.5]
            
            //cell.questionView.backgroundColor = color
            cell.perguntaTitulo.textColor = textColor
            cell.nickName.textColor = textColor
            cell.questionText.textColor = textColor
            
            let backgroundLayer = gl
            backgroundLayer.frame = cell.questionView.frame
            cell.questionView.layer.insertSublayer(backgroundLayer, atIndex: 0)
            
            
        }
        else{
            
            let textColor = UIColor.init(red: 255/255, green: 252/255, blue: 249/255, alpha: 1.0)
            let color = UIColor.init(red: 255/255, green: 105/255, blue: 120/255, alpha: 1.0)
            
            let gl = CAGradientLayer()
            
            gl.colors = [textColor.CGColor , color.CGColor, textColor.CGColor]
            gl.locations = [0.0,1.5]
            
            cell.questionView.backgroundColor = color
            cell.perguntaTitulo.textColor = textColor
            cell.nickName.textColor = textColor
            cell.questionText.textColor = textColor
            
            let backgroundLayer = gl
            backgroundLayer.frame = cell.questionView.frame
            cell.questionView.layer.insertSublayer(backgroundLayer, atIndex: 0)
        }
        */
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.chosenCell = self.tableView.cellForRowAtIndexPath(indexPath) as! QuestionFeedCell
        // Envio de informacao para a proxima tela atraves de um cell
        self.performSegueWithIdentifier("Answer", sender: self)
    }
    
    
    let threshold: CGFloat = -10.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            self.isLoadingMore = true
            self.getMoreQuestion()
            
        }
    }
    
    
    func getMoreQuestion(){
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findMoreQuestion(self.question.count) { (array, error) -> Void in
            
            if error == nil {
                
                if let array = array{
                    
                    self.question = self.question + array
                    self.tableView.reloadData()
                    self.isLoadingMore = false
                    
                }
                
            }
            self.activityIndicator.stopAnimating()
            
        }
        
        
    }
    
    // Criacao do vetor com as informacoes a serem apresentadas
    func getQuestion()
    {
        
        self.activityIndicator.startAnimating()
        
        ParseModel.findAllQuestion { (array, error) -> Void in
            
            if error == nil{
                
                if let array = array {
                
                    self.question = array
                
                }
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                
            }
        }
        
    }
    
    func salvarNovaPergunta(titleText:String, doubtText:String){
    
        ParseModel.salvarPergunta(titleText, tags: "Engenharia", texto: doubtText) { (sucesso, error) -> Void in
            
            if error == nil {
                self.getQuestion()
            }
            else{
                //tratar erro
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        // Como o texto e o icone a celula.
        if segue.identifier == "Answer" {
            
            if let destination = segue.destinationViewController as? AnswerViewController {
                let index = (self.tableView.indexPathForSelectedRow?.row)!
                destination.question = self.question[index]
            }
        }
        
        if segue.identifier == "criarPergunta"{
        
            if let destination = segue.destinationViewController as? CriaPerguntaViewController{
                destination.perguntaDelegate = self
            }
        }
        
    }
    
    
    
}





