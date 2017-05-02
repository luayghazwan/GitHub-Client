//
//  RepoViewController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/4/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    var allRepos = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    var displayRepos: [Repository]?{
        didSet{
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
        self.tableView.delegate = self
        
        let nib = UINib(nibName: RepoCell.identifier , bundle: Bundle.main)
        self.tableView.register(nib , forCellReuseIdentifier: RepoCell.identifier)
    }
    
    func update(){        
        GitHub.shared.getRepos { (repositories) in
            if let repositories = repositories {
                for repo in repositories {
                    self.allRepos.append(repo)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == RepoDetailViewController.identifier {
            segue.destination.transitioningDelegate = self as UIViewControllerTransitioningDelegate
            
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedRepo = self.allRepos[selectedIndex]
                
                guard let destinationController = segue.destination as? RepoDetailViewController else { return }
                
                destinationController.repo = selectedRepo
            }
        }
    }
}

extension RepoViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTransition(duration: 1.0) as? UIViewControllerAnimatedTransitioning
        
    }
}

extension RepoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repoCell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        
        let repo = self.allRepos[indexPath.row]
        
        repoCell.repo = repo
        
        return repoCell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRepos?.count ?? allRepos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: RepoDetailViewController.identifier, sender: nil)
    }

}

extension RepoViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
        
        }
        
        if let searchedText = searchBar.text {
            self.displayRepos = self.allRepos.filter({($0.name.contains(searchedText))})
        }
        if searchBar.text == "" {
            self.displayRepos = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayRepos = nil
        self.searchRepos.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchRepos.resignFirstResponder()
    }
    
}
