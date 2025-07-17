//
//  AuthManager.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 15.07.2025.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let isLoggedInKey = "isLoggedIn"
    
    private init () {}
    
    func logIn() {
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
    }
    
    func isLogginIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
}
