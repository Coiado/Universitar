//
//  FeedDetailsViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 29/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var navigationBarTitle: UINavigationBar!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var fullText: UITextView!
    
    var passedCell: FeedCell!
    
    override func viewDidLoad() {
        
        image.image = passedCell.picture.image
        fullText.text = passedCell.fullText
        subTitle.text = passedCell.subTitle.text
        navigationBarTitle.topItem?.title = passedCell.title.text
        
        fullText.layer.cornerRadius = 15
        fullText.layer.borderWidth = 3
        
    }
    
    
    func receiveCellData(cell: FeedCell) {
        self.passedCell = cell;
        
    }

    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
        
    }
    
    
    
    
}
