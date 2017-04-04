//
//  RepoViewController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/4/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let name : String
        let description : String
        let language : String
        
        
        update()
    }
    
    func update(){
        print("Update repo controller here!")
        
        GitHub.shared.getRepos { (repositories) in
            print(repositories?.first)
            
            //update tableView
            
        }
    }

}
