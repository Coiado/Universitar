//
//  AnswerViewController.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 11/2/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{

    
    @IBOutlet weak var tableViewAnswer: UITableView!
    @IBOutlet var tableViewQuestion: UITableView!
    var passedCell : QuestionFeedCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
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
    
    @IBAction func backQuestions(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(tableView == tableViewQuestion){
            return 1
        }
        else{
            return passedCell.answers.count
        }
    }
    
    
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == tableViewQuestion){
            let cell = tableViewQuestion.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as! AnswerQuestionTableViewCell
            cell.perguntaTitulo.text = passedCell.perguntaTitulo.text
            cell.userIcon.image = passedCell.userIcon.image
            cell.nickName.text = passedCell.nickName.text
            cell.questionText.text = passedCell.questionText.text
            cell.cardSetup()
            return cell
        }
        else{
            let cell = tableViewAnswer.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! AnswerTableViewCell
            let info = passedCell.answers[indexPath.row] as Answer
            cell.answerText.text = info.answerText
            cell.userIcon.image = info.userIcon
            cell.nickName.text = info.nickname
            cell.cardSetup()
            return cell
        }
    }

    
    @IBAction func sendQuestion(sender: AnyObject) {
        let alert = UIAlertView (title: "Invalido", message: "Em construção, estamos finalizando", delegate: self, cancelButtonTitle: "Ok")
        alert.show()
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
