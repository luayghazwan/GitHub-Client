//
//  Repository.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/4/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import Foundation

class Repository {
    
    let name: String
    let description: String?
    let language: String?
    
    init?(json: [String: Any]){
        if let name = json["name"] as? String {
            self.name = name
            self.description = json["description"] as? String
            self.language = json["language"] as? String
            
        } else {
            return nil
        }
    }
    
}
