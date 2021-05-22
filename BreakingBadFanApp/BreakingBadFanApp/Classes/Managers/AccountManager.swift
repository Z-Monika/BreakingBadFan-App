//
//  AccountManager.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import Foundation

struct AccountManager {
    
    enum AccountManagerError: Error {
        case missingValues
        case usernameTaken
        case passwordsDoNotMatch
        case wrongPassword
        case usernameNotFound
        case passwordNotSecure
        
        var errorDescription: String {
            switch self {
            case .missingValues:
                return "Either username or password is missing!"
            case .usernameTaken:
                return "Chosen username is already taken! Please choose a different username."
            case .passwordsDoNotMatch:
                return "Passwords do not match!"
            case .wrongPassword:
                return "Incorrect password!"
            case .usernameNotFound:
                return "Account with this username cannot be found!"
            case .passwordNotSecure:
                return "Password must be at least 8 characters, contain numbers and letters (both uppercase and lowercase), and  at least one special character!"
            }
        }
    }
    
    static var loggedInAccount: Account?
}

//MARK: - Register functionality -

extension AccountManager {
    
    static func registerAccount(username: String?, password: String?, loginStatus: Bool, confirmedPassword: String?) throws {
        guard
            let username = username,
            let password = password,
            let confirmedPassword = confirmedPassword,
            username.isNotEmpty,
            password.isNotEmpty,
            confirmedPassword.isNotEmpty
            else {
                throw AccountManagerError.missingValues
            }
        
        guard
            password == confirmedPassword
        else {
            throw AccountManagerError.passwordsDoNotMatch
        }
        
        guard
            !isUsernameTaken(username)
        else {
            throw AccountManagerError.usernameTaken
        }
        
        guard
            isPasswordSecure(password)
        else {
            throw AccountManagerError.passwordNotSecure
        }
        
        var account = Account(username: username, password: password, loginStatus: loginStatus)
        
        UserDefaultsManager.saveAccount(&account)
        UserDefaultsManager.saveLoggedInAccount(account)
        loggedInAccount = account
    }
}

//MARK: - Log in functionality -
extension AccountManager {
    
    static func loginUser(username: String?, password: String?, loginStatus: Bool) throws {
        guard
            let accounts = UserDefaultsManager.accounts
        else {
            throw AccountManagerError.usernameNotFound
        }

        for account in accounts where account.username == username {
            UserDefaultsManager.saveLoggedInAccount(account)
            
            guard
                password == UserDefaultsManager.getPassword(username: account.username)
            else {
                throw AccountManagerError.wrongPassword
            }
            loggedInAccount = account
            
            return
        }
        throw AccountManagerError.usernameNotFound
    }
}

//MARK: - Log out functionality -
extension AccountManager {
    
    static func logoutUser() {
        guard
            UserDefaultsManager.loggedInAccount != nil
        else {
            return
        }
        
        UserDefaultsManager.loggedInAccount = nil
        UserDefaults.standard.synchronize()
    }
}

//MARK: - Check username functionality -
private extension AccountManager {
    
    static func isUsernameTaken(_ username: String) -> Bool {
        guard
            let accounts = UserDefaultsManager.accounts
        else {
            return false
        }
        
        return accounts.contains { account -> Bool in
            account.username == username
        }
    }
}

//MARK: - Check password functionality -
private extension AccountManager {
    
    static func isPasswordSecure(_ password: String) -> Bool {
        guard
            password.count >= 8,
              password.containsSpecialCharacter
        else {
            return false
        }
        
        var containsUppercase = false
        var containsLowercase = false
        var containsNumber = false
        var containsLetter = false

        password.forEach { character in
            if character.isUppercase { containsUppercase = true }
            if character.isLowercase { containsLowercase = true }
            if character.isNumber { containsNumber = true }
            if character.isLetter { containsLetter = true }
        }
        return containsUppercase && containsLowercase && containsNumber && containsLetter
    }
}
