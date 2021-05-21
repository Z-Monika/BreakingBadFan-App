//
//  Account.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import Foundation

struct Account: Codable {
    var username: String
    var password: String
    
    init(username: String, password: String, loginStatus: Bool) {
        self.username = username
        self.password = password
    }
}

//MARK: - Password verification -

extension Account {
    var isPasswordSecure: Bool {
        guard password.count >= 8 else { return false }
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

