//
//  StringExtension.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    var containsSpecialCharacter: Bool {
       let regex = ".*[^A-Za-z0-9].*"
       let testString = NSPredicate(format:"SELF MATCHES %@", regex)
       return testString.evaluate(with: self)
    }
}
