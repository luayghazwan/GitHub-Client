//
//  GitHubAuthController.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/3/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GitHub.shared.token == "" {
            let parameters = ["scope": "email,user,repo"]
            GitHub.shared.oAuthRequestWith(parameters: parameters)
        } else {
            self.loginButton.backgroundColor = UIColor(rgb: 0xCCCCCC)
            self.loginButton.isUserInteractionEnabled = false
            self.loginButton.setTitle("Logged In", for: .disabled);
        }
    }
    
    func dismissAuthController(){
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    @IBAction func printTokenPressed(_ sender: Any) {
        let token = UserDefaults.standard.getAccessToken()
        print(token ?? "No Token Found")
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let parameters = ["scope" : "email,user,repo"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
    }
}
