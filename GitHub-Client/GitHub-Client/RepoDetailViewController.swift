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
        
//        presentWebViewControllerWith(urlString: repo.repoUrlString)
        
        presentSafariViewControllerWith(urlString: repo.repoUrlString)
        
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.UIViewControllerTransitioningDelegate = self
        
        self.dismissOutlet.layer.shadowColor = UIColor.gray.cgColor
        self.dismissOutlet.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.dismissOutlet.layer.shadowOpacity = 1.0
        self.dismissOutlet.layer.shadowRadius = 2
        self.dismissOutlet.layer.masksToBounds = true
        self.dismissOutlet.clipsToBounds = false
        
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

extension RepoDetailViewController : UIViewControllerTransitioningDelegate {
//    func anim
}
