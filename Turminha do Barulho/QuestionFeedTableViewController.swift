//
//  QuestionFeedTableViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

protocol novaPergunta {
    func salvarNovaPergunta(titleText:String, doubtText:String, user:String)
}

class QuestionFeedTableViewController: UITableViewController, UITextFieldDelegate,UITextViewDelegate, novaPergunta {

    @IBOutlet weak var pergunteButton: UIButton!
    
    var question : [Question] = []
    
    var chosenCell : QuestionFeedCell!
    
    // Questoes implementadas em hardcode elas serão colocadas no vetor de questoes, 
    // na funcao chamada createQuestion
    
    var answers1 = [Answer(nickname: "Jorge", userIcon: UIImage(named: "henrique"), answerText: "A Unicamp fornece moradia e alimentação de graça para estudantes de baixa renda. Além disso existe a oportunidade de conseguir bolsas trabalhos."), Answer(nickname: "ogari", userIcon: UIImage(named: "ogari"), answerText: "Apesar de oferecer tudo isso, as bolsas são escassas e não contemplam todos os alunos necessitados")]
    
    var answers2 = [Answer(nickname: "Leonardo", userIcon: UIImage(named: "lucas"), answerText: "É o melhor do Brasil!"), Answer(nickname: "Higor", userIcon: UIImage(named: "97"), answerText: "É muito bom, porém não é fácil.")]
    
    
    var answers3 = [Answer(nickname: "Leonardo", userIcon: UIImage(named: "lucas"), answerText: "Semana que vem, no sábado."), Answer(nickname: "Higor", userIcon: UIImage(named: "97"), answerText: "Nossa já ia esquecer, obrigado!")]
    
    // Cores que serao usadas para colorir o fundo da tableview
    let tableBG = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)

    
    override func viewDidAppear(animated: Bool) {
        
        self.tableView.reloadData()
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.createQuestion()
        
        configureButton()
        
        //self.tableView.separatorColor = UIColor.clearColor()
        //let backItem = UIBarButtonItem(title: "Voltar", style: .Bordered, target: nil, action: nil)
        //navigationItem.backBarButtonItem = backItem
        
        // Mudanca na coloracao da navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 255/255, green: 204/255, blue: 51/255, alpha: 1.0) ]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.backgroundColor = tableBG
        self.tableView.separatorColor = tableBG
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func configureButton(){
        
        self.pergunteButton.addTarget(self, action: "fazerPergunta", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
    func fazerPergunta(){
        
        print("testando a segue")
        
        self.performSegueWithIdentifier("fazerPergunta", sender: self)
        
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
        cell.userIcon.image = info.userIcon
        cell.userIcon.layer.cornerRadius = 15
        cell.userIcon.layer.masksToBounds = true
        cell.nickName.text = info.nickname
        cell.questionText.text = info.questionText
        
        // Fazendo com que o texto fique adaptavel com a celula da tableview
        cell.questionText.sizeToFit()
        cell.updateConstraints()
//        cell.answers = info.answers!
        cell.cardSetup()
        
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
    
    // Criacao do vetor com as informacoes a serem apresentadas
    func createQuestion()
    {
        
//        self.question.append(Question(nickname: "João", userIcon: UIImage(named: "97"), questionTitle: "Morar na Unicamp", questionText: "Como é permanência estudantil na Unicamp?", answers: self.answers1))
//        
//        
//        self.question.append(Question(nickname: "Fernão", userIcon: UIImage(named: "henrique"), questionTitle: "Engenharia", questionText: "Como é o curso de Engenharia de Computação na Unicamp?", answers: self.answers2))
//        
//        
//        self.question.append(Question(nickname: "Carlos", userIcon: UIImage(named: "ogari"), questionTitle: "Vestibular", questionText: "Quando é o ENEM?", answers: self.answers3))
        
        ParseModel.findAllQuestion { (array, error) -> Void in
            
            if error == nil{
                
                self.question = array!
                self.tableView.reloadData()
                
            }
            
        }
    }



    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            
//            self.view.endEditing(true)
            textView.resignFirstResponder()
            return false
        
        }
        
        return true
    }
    
    func salvarNovaPergunta(titleText:String, doubtText:String, user:String){
        
        if(titleText != "" && doubtText != ""){
            
//            self.question.append(Question(nickname: user, userIcon: UIImage(named: "userIcon"), questionTitle: titleText, questionText: doubtText, answers: []))
            self.tableView.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        // Como o texto e o icone a celula.
        if segue.identifier == "Answer" {
            if let destination = segue.destinationViewController as? AnswerViewController {
                let path = self.tableView?.indexPathForSelectedRow!
                let cell = self.tableView!.cellForRowAtIndexPath(path!) as! QuestionFeedCell
                destination.passedCell = cell
            }
        }
        
    }
    
}





