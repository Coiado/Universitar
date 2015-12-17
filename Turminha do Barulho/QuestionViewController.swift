//
//  AnswerViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/2/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

//protocol novaPergunta {
//    func salvarNovaPergunta(text:String, user:String)
//}
//
//class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, novaPergunta{
//    
//    
//    @IBOutlet weak var newQuestion: UITextField!
//    @IBOutlet var tableViewQuestion: UITableView!
//    var passedCell : QuestionFeedCell!
//    
//    
//    override func viewDidAppear(animated: Bool) {
//        self.tableViewQuestion.reloadData()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//        newQuestion.enabled = true
//        tableViewQuestion.estimatedRowHeight = 90
//        tableViewQuestion.rowHeight = UITableViewAutomaticDimension
//        self.tableViewQuestion.separatorStyle = UITableViewCellSeparatorStyle.init(rawValue: 1)!
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //MARK: - keyboardnotification
//    
//    //    func keyboardWillShow(sender: NSNotification) {
//    //        self.view.frame.origin.y -= 200
//    //    }
//    
//    // MARK: - Table view data source
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return passedCell.answers.count+2
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if(indexPath.row==0){
//            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionFeedCell
//            cell.perguntaTitulo.text = passedCell.perguntaTitulo.text
//            //            cell.perguntaTitulo.sizeToFit()
//            //            cell.updateConstraints()
//            cell.userIcon.image = passedCell.userIcon.image
//            cell.userIcon.layer.cornerRadius = 15
//            cell.nickName.text = passedCell.nickName.text
//            cell.questionText.text = passedCell.questionText.text
//            cell.questionText.font = UIFont(name: "Futura", size: 14.0)
//            
//            cell.questionText.sizeToFit()
//            cell.updateConstraints()
//            //cell.cardSetup()
//            return cell
//        }
//        else{if(indexPath.row==1){
//            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
//            let numberComments = String(passedCell.answers.count)
//            cell.comments.text = numberComments + " Comentários:"
//            cell.comments.font = UIFont(name: "Futura", size: 14.0)
//            
//            return cell
//        }
//        else{
//            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! AnswerTableViewCell
//            let info = passedCell.answers[indexPath.row-2] as Answer
//            cell.userIcon.image = info.userIcon
//            cell.userIcon.layer.masksToBounds = true
//            cell.userIcon.layer.cornerRadius = 15
//            cell.nickName.text = info.nickname
//            cell.nickName.font = UIFont(name: "Futura", size: 13.0)
//            cell.answerText.text = info.answerText
//            cell.answerText.font = UIFont(name: "Futura", size: 14.0)
//            cell.answerText.sizeToFit()
//            cell.updateConstraints()
//            cell.likes.text = String(15)
//            //cell.cardSetup()
//            return cell
//            }
//        }
//    }
//    
//    
//    func salvarNovaPergunta(text:String, user:String){
//        
//        if(text != ""){
//            passedCell.answers.append(Answer(nickname: user, userIcon:UIImage(named: "userIcon") , answerText: text))
//            tableViewQuestion.reloadData()
//        }
//        
//    }
//    
//    @IBAction func sendQuestion(sender: AnyObject) {
//        if(newQuestion.text != "" && newQuestion.text != nil){
//            passedCell.answers.append(Answer(nickname: "João", userIcon:UIImage(named: "userIcon") , answerText: newQuestion.text))
//            newQuestion.text = ""
//            tableViewQuestion.reloadData()
//        }
//    }
//    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        
//        performSegueWithIdentifier("responderPergunta", sender: self)
//        self.newQuestion.endEditing(true)
//        
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "responderPergunta"{
//            let destination = segue.destinationViewController as! CriaPerguntaViewController
//            
//            destination.perguntaDelegate = self // corrigir essa parte
//        }
//    }
//    
////            self.question.append(Question(nickname: "João", userIcon: UIImage(named: "97"), questionTitle: "Morar na Unicamp", questionText: "Como é permanência estudantil na Unicamp?", answers: self.answers1))
////    
//    
//    /*
//    // MARK: - Navigation
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    // Get the new view controller using segue.destinationViewController.
//    // Pass the selected object to the new view controller.
//    }
//    */
//    
//}
