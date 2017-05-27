//
//  RepoDetailViewController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/5/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit
import SafariServices

class RepoDetailViewController: UIViewController {
    
    var repo : Repository!

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoForked: UILabel!
    @IBOutlet weak var repoDateCreated: UILabel!
    @IBOutlet weak var repoUpdatedAt: UILabel!
    @IBOutlet weak var repoForkedTimes: UILabel!
    @IBOutlet weak var dismissOutlet: UIButton!
    @IBAction func moreDetailsPressed(_ sender: Any) {
        
        guard let repo = repo else {return}
        presentSafariViewControllerWith(urlString: repo.repoUrlString)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissOutlet.layer.shadowColor = UIColor.gray.cgColor
        self.dismissOutlet.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.dismissOutlet.layer.shadowOpacity = 1.0
        self.dismissOutlet.layer.shadowRadius = 1
        self.dismissOutlet.layer.masksToBounds = true
        
        if let repo = repo {
            self.repoName.text = repo.name
            self.repoDescription.text = repo.description
            self.repoLanguage.text = "Language: \(repo.language!)"
            self.repoStars.text = "Number of stars: \(String(repo.starGazers!))"
            
            if repo.isForked == true {
                self.repoForked.text = "This Repo is Forked"
                self.repoForkedTimes.text = String(repo.forksCount!)
            } else {
                self.repoForked.text = "This Repo has not been forked yet"
                self.repoForkedTimes.text = ""
            }
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            self.repoDateCreated.text = "Creation Date: \(formatter.string(from: repo.creationDate!))"
            self.repoUpdatedAt.text = "Last Updated on: \(formatter.string(from: repo.updateDate!))"
        }
    }
    
    func presentSafariViewControllerWith(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariController = SFSafariViewController(url: url)
        self.present(safariController, animated: true, completion: nil)
    }
    
    func presentWebViewControllerWith(urlString: String){
        let webController = WebViewController()
        webController.url = urlString
        self.present(webController, animated: true, completion: nil)
    }
    
    @IBAction func closeDetailController(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
