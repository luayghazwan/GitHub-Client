//
//  RepoViewController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/4/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UISearchBarDelegate {
    
    var allRepos = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchRepos: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchRepos.delegate = self
        self.tableView.dataSource = self
        self.searchRepos.delegate = self
        
        print("Count of all allRepos: \(allRepos.count)")
        
        
    }
    
    func update(){
        print("Update repo controller here!")
        
        GitHub.shared.getRepos { (repositories) in
            print(repositories?.first?.name)
            
            for repo in repositories! {
                self.allRepos.append(repo)
            }
//            RepoCell.repoName.text = repositories?.first?.description
            
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
    }

}

extension RepoViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repoCell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        
        let repo = self.allRepos[indexPath.row]
        
        repoCell.repo = repo
        
        return repoCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRepos.count
    }

}
