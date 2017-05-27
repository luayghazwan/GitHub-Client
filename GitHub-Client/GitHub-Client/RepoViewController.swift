//
//  RepoViewController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/4/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet weak var searchRepos: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var allRepos = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredRepos: [Repository]?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchRepos.delegate = self

        let nib = UINib(nibName: RepoCell.identifier , bundle: Bundle.main)
        self.tableView.register(nib , forCellReuseIdentifier: RepoCell.identifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    func update(){
        GitHub.shared.getRepos { (repositories) in
            self.allRepos = repositories?.sorted(by: { $0.creationDate > $1.creationDate}) ?? []
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

//MARK: RepoViewController Transitioning Delegate
extension RepoViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTransition(duration: 1.0) as? UIViewControllerAnimatedTransitioning
    }
}

//MARK: RepoViewController Delegate and DataSource
extension RepoViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRepos?.count ?? allRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        
        cell.repo = filteredRepos?[indexPath.row] ?? allRepos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: RepoDetailViewController.identifier, sender: nil)
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK: RepoViewController SearchBar Delegate
extension RepoViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
        }
        
        if searchBar.text == "" {
            filteredRepos = nil
            return
        }
        
        guard var filterText = searchBar.text else { return }
        filterText = filterText.lowercased()
        
        self.filteredRepos = self.allRepos.filter({
            $0.name.lowercased().contains(filterText) ||
            $0.description.lowercased().contains(filterText) ||
            $0.language.lowercased().contains(filterText)
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.filteredRepos = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
}
