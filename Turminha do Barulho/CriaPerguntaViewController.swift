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
        
        // fazer verificação
        
        if perguntaDelegate != nil{
            perguntaDelegate.salvarNovaPergunta(tituloTextField.text!,doubtText: perguntaTextView.text)
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
