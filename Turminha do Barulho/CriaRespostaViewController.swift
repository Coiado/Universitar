//
//  CriaRespostaViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 03/12/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class CriaRespostaViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var respostaTextView: UITextView!


    var respostaDelegate: novaResposta!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.respostaTextView.editable = true
        
        self.respostaTextView.becomeFirstResponder()
        
        self.respostaTextView.layer.cornerRadius = 15
        
    }
    

    @IBAction func responderAction(sender: AnyObject) {
        
        if respostaDelegate != nil{
            
            respostaDelegate.salvarNovaResposta(respostaTextView.text)

        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
