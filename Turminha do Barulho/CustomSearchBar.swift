//
//  CustomSearchBar.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 23/11/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    var preferredFont: UIFont!
    var preferredColor: UIColor!
    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        
        super.init(frame:frame)
        
        self.frame = frame
        
        self.preferredColor = textColor
        
        self.preferredFont = font
        
        self.searchBarStyle = UISearchBarStyle.Prominent
        translucent = false
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    func indexOfSearchFieldInSubviews() -> Int!{
        
        var index: Int!
        
        let searchBarView = subviews[0] 
        
        for var i = 0; i<searchBarView.subviews.count; ++i{
            
            if searchBarView.subviews[i].isKindOfClass(UITextField){
                index = i
                break
            }
        }
        
        return index
        
    }
    
    override func drawRect(rect: CGRect) {
        
        if let index = indexOfSearchFieldInSubviews(){
            
            // Access the search field
            let searchField: UITextField = (subviews[0]).subviews[index] as! UITextField
            
            // Set its frame.
            searchField.frame = CGRectMake(5.0, 5.0, frame.size.width - 10.0, frame.size.height - 10.0)
            
            // Set the font and text color of the search field.
            searchField.font = preferredFont
            searchField.textColor = preferredColor
            
            // Set the background color of the search field.
            searchField.backgroundColor = barTintColor
            
        }
        
        let startPoint = CGPointMake(0.0, frame.size.height)
        let endPoint = CGPointMake(frame.size.width, frame.size.height)
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = preferredColor.CGColor
        shapeLayer.lineWidth = 3.5
        
        layer.addSublayer(shapeLayer)
        
        super.drawRect(rect)
        
    }
    
    
    
    
}




