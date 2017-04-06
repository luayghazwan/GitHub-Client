//
//  RepoDetailViewController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/5/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    @IBOutlet weak var repoName: UILabel!
    
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var repoLanguage: UILabel!
    
    @IBOutlet weak var repoStars: UILabel!
    
    @IBOutlet weak var repoForked: UILabel!
    
    @IBOutlet weak var repoDateCreated: UILabel!
    
    @IBOutlet weak var repoUpdatedAt: UILabel!
    
    @IBOutlet weak var repoForkedTimes: UILabel!
    

    var repo : Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let repo = repo {
            self.repoName.text = repo.name
            self.repoDescription.text = repo.description
            self.repoLanguage.text = repo.language
            self.repoStars.text = repo.starGazers
            
            //Repo is forked
            if repo.isForked == true {
                self.repoForked.text = "This Repo has been forked"
            } else {
                self.repoForked.text = "This Repo has Not been forked yet"
            }
            
            self.repoDateCreated.text = repo.creationDate
            self.repoUpdatedAt.text = repo.updateDate
            
            self.repoForkedTimes.text = "This Repository has been forked \(String(describing: repo.forksCount))"
        }
        

        // Do any additional setup after loading the view.
    }



}
