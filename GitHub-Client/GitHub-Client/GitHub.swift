//
//  GitHub.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/3/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import UIKit

let kOAuthBaseURLString = "https://github.com/login/oauth/"

typealias GitHubOAuthCompletion = (Bool)->()
typealias FetchReposCompletion = ([Repository]?)->()

enum SaveOptions{
    case userDefaults
}

enum GitHubAuthError : Error {
    case extractingCode
}

class GitHub {
    
    private var session: URLSession
    private var components: URLComponents
    
    var token = ""
    
    static let shared = GitHub()
    var repositoriesArray = [Repository]()
    
    private init(){
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()
        self.components.scheme = "https"
        self.components.host = "api.github.com"
    }
    
    func oAuthRequestWith(parameters: [String : String]){
        var parametersString = ""
        
        for (key,value) in parameters {
            parametersString += "&\(key)=\(value)"
        }
        print("Parameters String: \(parametersString)")
        
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubClientID)\(parametersString)"){
            
            UIApplication.shared.open(requestURL)
            print(requestURL.absoluteString)
        }
    }
    
    func getCodeFrom(url: URL) throws -> String {
        print(url.absoluteString)
        guard let code = url.absoluteString.components(separatedBy: "=").last else {throw GitHubAuthError.extractingCode
        }
        print("this is the code:\(code)")
        return code
    }
    
    func accessTokenFrom(_ string: String) -> String? {
        print(print)
        
        if string.contains("access_token"){
            let components = string.components(separatedBy: "&")
            for component in components {
                if component.contains("access_token"){
                    let token = component.components(separatedBy: "=").last
                    return token
                }
            }
        }
        return nil
    }
    
    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion) {
        func complete(success: Bool){
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        
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

                        if UserDefaults.standard.save(accessToken: self.accessTokenFrom(dataString)!) {
                            print("Token Saved")
                        }
                        complete(success: true)
                    }
                }).resume()
            }
        } catch {
            print(error)
            complete(success: false)
        }
    }
    
    func getRepos(completion: @escaping FetchReposCompletion){
        
        if let token = UserDefaults.standard.getAccessToken(){
            let queryItem = URLQueryItem(name: "access_token", value: token)
            self.components.queryItems = [queryItem]
        }
        
        func returnToMain(results: [Repository]?){
            OperationQueue.main.addOperation {
                completion(results)
            }
        }
        
        self.components.path = "/user/repos"
        
        guard let url = self.components.url else { returnToMain(results: nil); return}
        
        self.session.dataTask(with: url) { (data, response, error) in
            if error != nil { returnToMain(results: nil) ; return }
            if let data = data {
                
                var repositories = [Repository]()
                
                do {
                    if let rootJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] {
                        for repositoryJSON in rootJson {
                            if let repo = Repository(json: repositoryJSON){
                                repositories.append(repo)
                            }
                        }
                        self.repositoriesArray = repositories
                        returnToMain(results: repositories)
                    }
                } catch {
                }
            }
        }.resume()
    }
}
