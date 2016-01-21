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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //Precisamos popular
        
        return cell
        
    }
    
}
