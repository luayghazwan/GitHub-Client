//
//  GitHubAuthController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/3/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    @IBAction func printTokenPressed(_ sender: Any) {
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        let parameters = ["scope" : "email,user"]
        
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

}
