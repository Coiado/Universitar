//
//  Materia.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/20/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import Foundation
import MapKit

struct Materia {
    let identifier: Int
    let name: String
    let description: String
    let icon: String
    let Universidades: NSArray
    let color: UIColor
}

// MARK: - Support for loading data from plist

extension Materia {
    
    static func loadAllMateria() -> [Materia] {
        return loadMateriaFromPlistNamed("materias")
    }
    
    private static func loadMateriaFromPlistNamed(plistName: String) -> [Materia] {
        guard
            let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist"),
            let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
            else {
                fatalError("An error occurred while reading \(plistName).plist")
        }
        
        var MateriasArray = [Materia]()
        
        for dict in dictArray {
            guard
                let identifier    = dict["identifier"]    as? Int,
                let name          = dict["name"]          as? String,
                let description  = dict["description"]  as? String,
                let icon = dict["icon"] as? String,
                let Universidades = dict["Universidades"]      as? NSArray,
                let color = dict["color"]      as? NSArray
                else {
                    fatalError("Error parsing dict \(dict)")
            }
            let red = CGFloat(color[0] as! NSNumber)/255
            let green = CGFloat(color[1] as! NSNumber)/255
            let blue = CGFloat(color[2] as! NSNumber)/255
            let materia = Materia(identifier: identifier, name: name, description: description, icon: icon, Universidades: Universidades, color: UIColor(red: red, green: green, blue: blue, alpha: 1))
            MateriasArray.append(materia)
        }
        
        return MateriasArray
    }
}