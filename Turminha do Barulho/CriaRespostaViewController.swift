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

    @IBOutlet weak var wordCount: UILabel!

    var respostaDelegate: novaResposta!
    
    let stringMaxLength: Int = 910
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.respostaTextView.editable = true
        
        self.wordCount.text = String(stringMaxLength)
        
        self.respostaTextView.becomeFirstResponder()
        
        self.respostaTextView.layer.cornerRadius = 15
        
    }
    
    func textViewDidChange(textView: UITextView) {
        
        let string:String = self.respostaTextView.text
        
        self.wordCount.text = String(stringMaxLength - string.characters.count)
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 911;
    }

    @IBAction func responderAction(sender: AnyObject) {
        
        if respostaDelegate != nil{
            
            respostaDelegate.salvarNovaResposta(respostaTextView.text, user: "josé")

        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
