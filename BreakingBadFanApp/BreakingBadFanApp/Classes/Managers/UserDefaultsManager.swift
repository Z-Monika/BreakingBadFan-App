//
//  UserDefaultsManager.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import Foundation

struct UserDefaultsManager {
    
    enum UserDefaultsManagerKey {
        static let accounts = "Accounts"
        static let quotes = "Quotes"
        static let loggedInAccount = "LoggedInAccount"
    }
   
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    private static var keyChain: KeychainSwift {
        KeychainSwift()
    }
    
    static func saveAccount(_ account: inout Account) {
        var savedAccounts: [Account] = []
        
        if let accounts = accounts {
            savedAccounts = accounts
        }
        
        savePassword(account.password, username: account.username)
        account.password = ""
        savedAccounts.append(account)
        accounts = savedAccounts
    }
    
    static func saveLoggedInAccount(_ account: Account) {
        loggedInAccount = account
    }
    
    static func saveQuote(_ quote: FavoriteQuote) {
        var savedQuotes: [FavoriteQuote] = []
        if let quotes = quotes {
            savedQuotes = quotes
        }
        savedQuotes.append(quote)
        quotes = savedQuotes
    }
}

//MARK: - Save user details -
extension UserDefaultsManager {
    
    static var accounts: [Account]? {
        get {
            guard
                let encodedAccounts = userDefaults.object(forKey: UserDefaultsManagerKey.accounts) as? Data
            else {
                return nil
            }
            return try? JSONDecoder().decode([Account].self, from: encodedAccounts)
        } set {
            let encodedAccounts = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedAccounts, forKey: UserDefaultsManagerKey.accounts)
        }
    }
    
    private static func savePassword(_ password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    static func getPassword(username: String) -> String? {
        keyChain.get(username)
    }
}

//MARK: - Save logged in account -
extension UserDefaultsManager {
    
    static var loggedInAccount: Account? {
        get {
            guard
                let encodedLoggedInAccount = userDefaults.object(forKey: UserDefaultsManagerKey.loggedInAccount) as? Data
            else {
                return nil
            }
            return try? JSONDecoder().decode(Account.self, from: encodedLoggedInAccount)
        } set {
            let encodedLoggedInAccount = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedLoggedInAccount, forKey: UserDefaultsManagerKey.loggedInAccount)
        }
    }
}

//MARK: - Save quote details -
extension UserDefaultsManager {
    
    static var quotes: [FavoriteQuote]? {
        get {
            guard
                let encodedQuotes = userDefaults.object(forKey: UserDefaultsManagerKey.quotes) as? Data
            else {
                return nil
            }
            return try? JSONDecoder().decode([FavoriteQuote].self, from: encodedQuotes)
        } set {
            let encodedQuotes = try? JSONEncoder().encode(newValue)
            userDefaults.set(encodedQuotes, forKey: UserDefaultsManagerKey.quotes)
        }
    }
}
