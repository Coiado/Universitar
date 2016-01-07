//
//  CriarPergunta.swift
//  Turminha do Barulho
//
//  Created by Ogari Pata Pacheco on 09/12/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class CriaPerguntaViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var respostaTextView: UITextView!
    
    @IBOutlet weak var wordCount: UILabel!
    
    var respostaDelegate: novaResposta!
    var question : [Question] = []
    
    let stringMaxLength: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.respostaTextView.editable = true
        
        self.wordCount.text = String(stringMaxLength)
        
        self.respostaTextView.becomeFirstResponder()
    }
    
    func textViewDidChange(textView: UITextView) {
        
        let string:String = self.respostaTextView.text
        
        self.wordCount.text = String(stringMaxLength - string.characters.count)
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 101;
    }
    
    @IBAction func responderAction(sender: AnyObject) {
        
        print("action")
        
        if respostaDelegate != nil{
            
            print("if")
            

            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
