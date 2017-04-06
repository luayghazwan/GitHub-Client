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
    let starGazers: String?
    let isForked: Bool?
    let creationDate: String?
    let updateDate: String?
    let forksCount: Int?
    
    init?(json: [String: Any]){
        if let name = json["name"] as? String {
            self.name = name
            self.description = json["description"] as? String
            self.language = json["language"] as? String
            self.starGazers = json["stargazers_url"] as? String
            self.isForked = json["fork"] as? Bool
            self.creationDate = json["created_at"] as? String
            self.updateDate = json["updated_at"] as? String
            self.forksCount = json["forks_count"] as? Int
        } else {
            return nil
        }
    }
    
}
