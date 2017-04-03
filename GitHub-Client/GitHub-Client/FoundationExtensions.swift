//
//  FoundationExtensions.swift
//  GitHub-Client
//
//  Created by Luay Younus on 4/3/17.
//  Copyright © 2017 Luay Younus. All rights reserved.
//

import Foundation

extension UserDefaults {
    //accessor method to spit out token if it has one
    func getAccessToken()-> String? {
        //access the token inside the user's default .. give me the string for the access_token
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return nil }
        
        return token
    }
    
    //method to save the token...
    func save(accessToken: String) -> Bool {
        UserDefaults.standard.set(accessToken, forKey: "access_token")
        
         //sync all data in our defaults.. returns Boolean .. tell if it was successful or not
        return UserDefaults.standard.synchronize()
        
    }
}
