//
//  Universidade.swift
//  Turminha do Barulho
//
//  Created by Lucas Coiado Mota on 10/23/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

//import Foundation
//import MapKit
//
//struct Universidades{
//    let identifier: Int
//    let name: String
//    let locationName: String
//    let thumbnailName: String
//    let whyVisit: String
//    let whatToSee: String
//    let weatherInfo: String
//    let userRating: Int
//    let wikipediaURL: NSURL
//    let coordinate: CLLocationCoordinate2D
//}
//
//// MARK: - Support for loading data from plist
//
//extension Universidades {
//    
//    static func loadAllUniversidades() -> [Universidades] {
//        return loadUniversidadesFromPlistNamed("vacation_spots")
//    }
//    
//    private static func loadUniversidadesFromPlistNamed(plistName: String) -> [Universidades] {
//        guard
//            let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist"),
//            let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
//            else {
//                fatalError("An error occurred while reading \(plistName).plist")
//        }
//        
//        var Universidades = [Universidades]()
//        
//        for dict in dictArray {
//            guard
//                let identifier    = dict["identifier"]    as? Int,
//                let name          = dict["name"]          as? String,
//                let locationName  = dict["locationName"]  as? String,
//                let thumbnailName = dict["thumbnailName"] as? String,
//                let whyVisit      = dict["whyVisit"]      as? String,
//                let whatToSee     = dict["whatToSee"]     as? String,
//                let weatherInfo   = dict["weatherInfo"]   as? String,
//                let userRating    = dict["userRating"]    as? Int,
//                let wikipediaLink = dict["wikipediaLink"] as? String,
//                let latitude      = dict["latitude"]      as? Double,
//                let longitude     = dict["longitude"]     as? Double
//                else {
//                    fatalError("Error parsing dict \(dict)")
//            }
//            
//            let wikipediaURL = NSURL(string: wikipediaLink)!
//            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            let vacationSpot = VacationSpot(
//                identifier: identifier,
//                name: name,
//                locationName: locationName,
//                thumbnailName: thumbnailName,
//                whyVisit: whyVisit,
//                whatToSee: whatToSee,
//                weatherInfo: weatherInfo,
//                userRating: userRating,
//                wikipediaURL: wikipediaURL,
//                coordinate: coordinate
//            )
//            
//            vacationSpots.append(vacationSpot)
//        }
//        
//        return vacationSpots
//    }
//}