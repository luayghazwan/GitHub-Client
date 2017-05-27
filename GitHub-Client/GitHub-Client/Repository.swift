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
    let description: String
    let language: String
    let starGazers: Int
    let isForked: Bool
    var creationDate: Date
    var updateDate: Date
    let forksCount: Int
    let repoUrlString : String
    
    init?(json: [String: Any]){
        if let name = json["name"] as? String {
            self.name = name
            
            self.description = json["description"] as? String ?? ""
            self.language = json["language"] as? String ?? ""
            
            self.starGazers = json["stargazers_count"] as? Int ?? 0
            self.isForked = json["fork"] as? Bool ?? false
            
            guard let creationDateString = json["created_at"] as? String else { return nil }
            guard let updateDateString = json["updated_at"] as? String else { return nil }

            let dateFormatter = ISO8601DateFormatter()
            
            guard let creationDate = dateFormatter.date(from: creationDateString) else { return nil }
            self.creationDate = creationDate
            
            guard let updateDate = dateFormatter.date(from: updateDateString) else { return nil }
            self.updateDate = updateDate
            
            self.forksCount = json["forks_count"] as? Int ?? 0
            self.repoUrlString = json["html_url"] as? String ?? "https://www.github.com"
            
        } else {
            return nil
        }
    }
    
}
