//
//  QuotesResponse.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-02.
//

import Foundation

struct Quote: Codable, Hashable {
    let quoteId: Int
    let quote: String
    let author: String
    
    private enum CodingKeys: String, CodingKey {
        case quoteId = "quote_id"
        case quote
        case author
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        quoteId = try values.decode(Int.self, forKey: .quoteId)
        quote = try values.decode(String.self, forKey: .quote)
        author = try values.decode(String.self, forKey: .author)
    }
}
