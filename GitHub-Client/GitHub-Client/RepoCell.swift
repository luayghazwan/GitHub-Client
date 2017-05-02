//
//  repoCell.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/4/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var repoName: UILabel!

    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var repoLanguage: UILabel!

    var repo: Repository! {
        didSet {
            self.repoName.text = repo.name
            self.repoDescription.text = repo.description
            self.repoLanguage.text = repo.language
        }
    }
    
}
