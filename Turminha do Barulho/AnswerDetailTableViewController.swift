//
//  AnswerDetailTableViewController.swift
//  Turminha do Barulho
//
//  Created by Henrique de Abreu Amitay on 21/01/16.
//  Copyright © 2016 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class AnswerDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var passedCell:AnswerTableViewCell?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .None
    }
    
    //TABLEVIEW METHODS
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AnswerCell",forIndexPath: indexPath) as! AnswerTableViewCell

        cell.usuario = passedCell?.usuario
        cell.usuarioId = passedCell?.usuarioId
        
        cell.answerDate.text = passedCell?.answerDate.text
        
//        cell.denunciaButton.addTarget(self, action: "denunciaComentario", forControlEvents: UIControlEvents.TouchUpInside)
        

        cell.userIcon.image = passedCell?.userIcon.image
        
        cell.userIcon.layer.masksToBounds = true
        cell.userIcon.layer.cornerRadius = 15
        cell.nickName.text = passedCell?.nickName.text
        cell.nickName.font = UIFont(name: "Futura", size: 13.0)
        cell.answerText.text = passedCell?.fullAnswer
        cell.answerText.font = UIFont(name: "Futura", size: 14.0)
        cell.answerText.sizeToFit()
        cell.updateConstraints()
        //cell.cardSetup()
        return cell

        
    }
    
}