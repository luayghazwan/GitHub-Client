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
    
    
    
    @IBAction func printTokenPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let parameters = ["scope" : "email,user,repo"]
        
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        

        
    }
    
    func dismissAuthController(){
        //if this auth controller is presented over other controllers,  we will remove the view of the controller
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tokenChecker = UserDefaults.standard.getAccessToken()
        
        if tokenChecker != nil {
            
            self.loginButton.backgroundColor = UIColor(rgb: 0xCCCCCC)
            self.loginButton.isUserInteractionEnabled = false
        }
        
    }

}
