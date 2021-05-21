//
//  FavoriteQuote.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-04.
//

import Foundation

struct FavoriteQuote: Codable, Hashable {
    var username: String
    let quote: Quote

    init(username: String, quote: Quote) {
        self.username = username
        self.quote = quote
    }
}
