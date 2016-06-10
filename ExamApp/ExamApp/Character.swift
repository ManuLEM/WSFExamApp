//
//  Character.swift
//  ExamApp
//
//  Created by Manuel on 10/06/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import Foundation
import Alamofire

struct Character {
    let name: String
    let height: Int
    let mass: Int
    let gender: String
    let homeworld: String
    let species: String
    
    init(dict: Dictionary<String, AnyObject>) {
        name = dict["name"] as! String
        height = dict["height"] as! Int
        mass = dict["mass"] as! Int
        gender = dict["gender"] as! String
        homeworld = dict["homeworld"] as! String
        
        let mainSpecies = dict["species"] as! [String]
        species = mainSpecies[0]
    }

}

extension Character {
    static func getRemoteCharacters(offset: Int, completionHandler: Response<AnyObject, NSError> -> Void) {
        Alamofire.request(.GET, "http://swapi.co/api/people/?format=json").responseJSON { response in
            completionHandler(response)
        }
    }
}