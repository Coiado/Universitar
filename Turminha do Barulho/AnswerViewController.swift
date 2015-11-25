//
//  AnswerViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/2/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{

    
    @IBOutlet weak var newQuestion: UITextField!
    @IBOutlet var tableViewQuestion: UITableView!
    var passedCell : QuestionFeedCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        newQuestion.enabled = true
        tableViewQuestion.estimatedRowHeight = 90
        tableViewQuestion.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - keyboardnotification
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 200
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return passedCell.answers.count+2
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionFeedCell
            cell.perguntaTitulo.text = passedCell.perguntaTitulo.text
            cell.userIcon.image = passedCell.userIcon.image
            cell.nickName.text = passedCell.nickName.text
            cell.questionText.text = passedCell.questionText.text
            cell.questionText.sizeToFit()
            cell.updateConstraints()
            cell.cardSetup()
            return cell
        }
        else{if(indexPath.row==1){
            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
            var numberComments = String(passedCell.answers.count)
            cell.comments.text = numberComments+" Comentários:"
            
            return cell
            }
            else{
                let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! AnswerTableViewCell
                let info = passedCell.answers[indexPath.row-2] as Answer
                cell.answerText.text = info.answerText
                cell.answerText.sizeToFit()
                cell.updateConstraints()
                cell.userIcon.image = info.userIcon
                cell.nickName.text = info.nickname
                cell.likes.text = String(15)
                cell.cardSetup()
                return cell
            }
        }
    }

    
    
    @IBAction func sendQuestion(sender: AnyObject) {
        if(newQuestion.text != "" && newQuestion.text != nil){
            passedCell.answers.append(Answer(nickname: "João", userIcon:UIImage(named: "userIcon") , answerText: newQuestion.text))
            newQuestion.text = ""
           tableViewQuestion.reloadData()
        }
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.view.frame.origin.y -= self.view.frame.origin.y
        return false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
