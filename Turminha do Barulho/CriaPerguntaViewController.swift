//
//  CriaRespostaViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 03/12/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class CriaPerguntaViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var perguntaTextView: UITextView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var titleWordCount: UILabel!
    
    var perguntaDelegate: novaPergunta!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.perguntaTextView.editable = true
        self.perguntaTextView.becomeFirstResponder()
      //  self.tituloTextField.becomeFirstResponder()
        self.perguntaTextView.layer.cornerRadius = 15
        self.tituloTextField.layer.cornerRadius = 15
        
        
    }
    
    
    @IBAction func perguntarAction(sender: AnyObject) {
        
        // titleText:String, doubtText:String, user:String, answer: [Answer]
        
        if perguntaDelegate != nil{
            perguntaDelegate.salvarNovaPergunta(tituloTextField.text!,doubtText: perguntaTextView.text, user: "josé" )
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
