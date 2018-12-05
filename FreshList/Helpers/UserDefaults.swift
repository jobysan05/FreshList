//
//  UserDefaults.swift
//  FreshList
//
//  Copyright © 2018 ubiqteam7fall. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum userDefaultKeys: String {
        case isLoggedIn
        case userEmail
        case userID
    }
    func setisLoggedIn(value: Bool) {
        set(value, forKey: userDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func getisLoggedIn() -> Bool {
        return bool(forKey: userDefaultKeys.isLoggedIn.rawValue)
    }
    
    func setUserEmail(value: String) {
        set(value, forKey: userDefaultKeys.userEmail.rawValue)
    }
    
    func getUserEmail() -> String {
        return string(forKey: userDefaultKeys.userEmail.rawValue)!
    }
    
    func setUserID(value: String) {
        set(value, forKey: userDefaultKeys.userID.rawValue)
    }
    
    func getUserID() -> String {
        return string(forKey: userDefaultKeys.userID.rawValue)!
    }
}
