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
    
    let stringMaxLength: Int = 140
    let titleMaxLength: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.perguntaTextView.editable = true
        self.wordCount.text = String(stringMaxLength)
        self.titleWordCount.text = String(titleMaxLength)
        self.perguntaTextView.becomeFirstResponder()
      //  self.tituloTextField.becomeFirstResponder()
    }
    
    func textViewDidChange(textView: UITextView) {
        let string:String = self.perguntaTextView.text
        self.wordCount.text = String(stringMaxLength - string.characters.count)
        
    }
    
    
    func titleChanged(textField:UITextField){
        let string:String = self.tituloTextField.text!
        self.titleWordCount.text = String(titleMaxLength - string.characters.count)
    
    }
    
    // Para a duvida
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 141
    }
    
    // Para o titulo
    func textField(textField: UITextField, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 51
    }
    
    @IBAction func perguntarAction(sender: AnyObject) {
        
        // titleText:String, doubtText:String, user:String, answer: [Answer]
        
        if perguntaDelegate != nil{
            perguntaDelegate.salvarNovaPergunta(tituloTextField.text!,doubtText: perguntaTextView.text, user: "josé" )
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
