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

typealias GitHubOAuthCompletion = (Bool)->()

//save the token in memory
// userDefaults is almost identical to local Storage
enum SaveOptions{
    case userDefaults
}

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
    
    //escaping because its asynchronous
    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion) {
        
        
        //by making this function we wont need to add OPerationQueue everytime
        func complete(success: Bool){
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        
        //get my code
        do{
            let code = try self.getCodeFrom(url: url)
            
            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(gitHubClientID)&client_secret=\(gitHubClientSecret)&code=\(code)"
        
            if let requestURL = URL(string: requestString){
                
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                    
                    if error != nil {complete(success: false)}
                    
                    
                    guard let data = data else { complete(success: false) ; return}
                    
                    if let dataString = String(data: data, encoding: .utf8){
                        print(dataString)
                        
                        complete(success: true)
                    }
                    
                }).resume() //The most common bug to start or resume the dataTask
            }
        
        } catch { //'catch let error' error is implied
            print(error)
            complete(success: false)
        }
        
        
        
        
    }
}
