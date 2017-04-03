//
//  GitHub.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/3/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

// k or g - constant that is available gloabally
let kOAuthBaseURLString = "https://github.com/login/oauth/"

enum GitHubAuthError : Error {
    case extractingCode
}

class GitHub {
    
    static let shared = GitHub()
    
    func oAuthRequestWith(parameters: [String : String]){
        var parametersString = "" //will represent everything after the ? mark
        
        for (key,value) in parameters {
            parametersString += "&\(key)=\(value)"
        }
        
        print("Parameters String: \(parametersString)")
        
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubClientID)\(parametersString)"){
            print(requestURL.absoluteString) //Stringifiying the URL with Absolute
            
            UIApplication.shared.open(requestURL)
        }
    }
    
    //we will try to get a URL , otherwise throw the error defined in the enum
    func getCodeFrom(url: URL) throws -> String {
        
        
        //seperate the components by '=' .. taking the strings and returning array of strings
        guard let code = url.absoluteString.components(separatedBy: "=").last else {throw GitHubAuthError.extractingCode
        }
        return code
    }
}
