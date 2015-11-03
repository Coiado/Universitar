//
//  QuestionFeedTableViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class QuestionFeedTableViewController: UITableViewController {

    var question : [Question] = []
    
    var chosenCell : QuestionFeedCell!
    
    var answers = [Answer(nickname: "Jorge", userIcon: UIImage(named: "userIcon"), answerText: "É bom sim!"), Answer(nickname: "Joaquim", userIcon: UIImage(named: "userIcon"), answerText: "Não gosto")]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.createQuestion()
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
        return question.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("questionFeedCell", forIndexPath: indexPath) as! QuestionFeedCell

        let info = question[indexPath.row] as Question
        cell.perguntaTitulo.text = info.questionTitle
        cell.userIcon.image = info.userIcon
        cell.nickName.text = info.nickname
        cell.questionText.text = info.questionText
        cell.answers = info.answers
        cell.cardSetup()
        

        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.chosenCell = self.tableView.cellForRowAtIndexPath(indexPath) as! QuestionFeedCell
        self.performSegueWithIdentifier("Answer", sender: self)
    }
    
   
    
    
    
    func createQuestion()
    {
        
        self.question.append(Question(nickname: "João", userIcon: UIImage(named: "userIcon"), questionTitle: "Bandeco da Unicamp", questionText: "O Bandeco da Unicamp é bom?", answers: self.answers))
        
        
        self.question.append(Question(nickname: "Paulo", userIcon: UIImage(named: "userIcon"), questionTitle: "Engenharia", questionText: "Como é o curso de eng. na Unicamp?", answers: self.answers))
        
        
        self.question.append(Question(nickname: "Maria", userIcon: UIImage(named: "userIcon"), questionTitle: "Vestibular", questionText: "Quando é o ENEM?", answers: self.answers))
        
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

    
    
    //MARK: Criar pergunta
    
    
    var criarPerguntaView = UIView()
    
    var tituloTextfield = UITextField()
    
    var perguntaTextview = UITextView()
    
    @IBAction func CriaPergunta(sender: AnyObject) {
        
        criarPerguntaView.frame =  CGRect(x: self.view.frame.width*0.05, y: self.view.frame.height * 0.05, width:
            self.view.frame.width*0.90, height: self.view.frame.height*0.85)
        
        criarPerguntaView.backgroundColor = UIColor.grayColor()
        
        criarPerguntaView.layer.cornerRadius = 10
        
        self.view.addSubview(criarPerguntaView)
        
        let closeButton = UIButton()
        
        closeButton.setTitle("X", forState: .Normal)
        
        closeButton.layer.cornerRadius = 10
        closeButton.backgroundColor = UIColor.blackColor()
        
        closeButton.addTarget(self, action: "closeTutorial", forControlEvents: UIControlEvents.TouchUpInside)
        closeButton.frame = CGRect(x: self.criarPerguntaView.frame.width*0.85, y: 10, width: self.criarPerguntaView.frame.width * 0.1 ,  height: self.criarPerguntaView.frame.width * 0.1)
        self.criarPerguntaView.addSubview(closeButton)
        
        tituloTextfield.attributedText = nil
        tituloTextfield.placeholder = "Título"
        
        tituloTextfield.frame = CGRect(x: self.criarPerguntaView.frame.width*0.1, y: self.criarPerguntaView.frame.height*0.1, width: self.criarPerguntaView.frame.width*0.8, height: self.criarPerguntaView.frame.height*0.07)
        
        tituloTextfield.layer.cornerRadius = 10
        
        tituloTextfield.backgroundColor = UIColor.whiteColor()
        
        self.criarPerguntaView.addSubview(tituloTextfield)

        perguntaTextview.attributedText = nil
        perguntaTextview.frame = CGRect(x: self.criarPerguntaView.frame.width*0.1, y: self.criarPerguntaView.frame.height*0.25, width: self.criarPerguntaView.frame.width*0.8, height: self.criarPerguntaView.frame.height*0.6)

        perguntaTextview.layer.cornerRadius = 10
        
        perguntaTextview.backgroundColor = UIColor.whiteColor()
        
        self.criarPerguntaView.addSubview(perguntaTextview)
        
        
        let criaButton = UIButton()
        
        criaButton.layer.cornerRadius = 10
        criaButton.setTitle("Criar", forState: .Normal)
        criaButton.frame = CGRect(x: self.criarPerguntaView.frame.width*0.425, y: self.criarPerguntaView.frame.height*0.825, width: self.criarPerguntaView.frame.width * 0.15 ,  height: self.criarPerguntaView.frame.width * 0.4)
        criaButton.addTarget(self, action: "criaPergunta", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.criarPerguntaView.addSubview(criaButton)
        
        
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func criaPergunta()
    {
        
        let titulo = tituloTextfield.text
        
        let pergunta = perguntaTextview.text
        
        if titulo != "" {
            
            if pergunta != ""{
                print("titulo = \(titulo) e pergunta = \(pergunta)")
                self.question.append(Question(nickname: "Bruno", userIcon: UIImage(named: "userIcon"), questionTitle: titulo, questionText: pergunta, answers: self.answers))
                
                
                for subview in self.criarPerguntaView.subviews{
                    subview.removeFromSuperview()
                }
                
                self.criarPerguntaView.removeFromSuperview()

                self.tableView.reloadData()
            }
            else{
                let alert = UIAlertView (title: "Erro", message: "Preencha a pergunta", delegate: self, cancelButtonTitle: "Ok")
            }
        }
        
        else{
            
            let alert = UIAlertView (title: "Erro", message: "Preencha o título", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
            
        }
        
    }
    
    func closeTutorial()
    {
        
        for subview in self.criarPerguntaView.subviews{
            subview.removeFromSuperview()
        }
        
        self.criarPerguntaView.removeFromSuperview()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Passamos as informacoes da celula selecionada, depois precisamos atrelar mais informacoes
        //Como o texto e o icone a celula.
        if segue.identifier == "Answer" {
            if let destination = segue.destinationViewController as? AnswerViewController {
                let path = self.tableView?.indexPathForSelectedRow!
                let cell = self.tableView!.cellForRowAtIndexPath(path!) as! QuestionFeedCell
                destination.passedCell = cell
                }
        }
//        let secondViewController = segue.destinationViewController as! AnswerTableViewController
//        
//        let cell = self.chosenCell
//        
//        secondViewController.receiveCellData(cell!);
        
    }
    
}





