//
//  APIEndpoint.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-26.
//

import Foundation

enum APIEndpoint {
    case getEpisodes
    case getCharacters
    case getCharacter(name: String)
    case getQuotes(author: String)
    case getRandomQuote
    
    var url: URL? {
        switch self {
        case .getEpisodes:
            return makeURL(endpoint: "episodes?series=Breaking+Bad")
        case .getCharacters:
            return makeURL(endpoint: "characters?category=Breaking+Bad")
        case .getCharacter(let name):
            let queryItem = URLQueryItem(name: CharacterNameQueryKey, value: "\(name)")
            return makeURL(endpoint: "characters", queryItems: [queryItem])
        case .getQuotes(let author):
            let queryItem = URLQueryItem(name: QuoteAuthorQueryKey, value: "\(author)")
            return makeURL(endpoint: "quote", queryItems: [queryItem])
        case .getRandomQuote:
            return makeURL(endpoint: "quote/random")
        }
    }
}

//MARK: - Composing URL functionality -

private extension APIEndpoint {
    
    var CharacterNameQueryKey: String {
        "name"
    }
    
    var QuoteAuthorQueryKey: String {
        "author"
    }
    
    var BaseURL: String {
        "https://www.breakingbadapi.com/api/"
    }
    
    func makeURL(endpoint: String,  queryItems: [URLQueryItem]? = nil) -> URL? {
        let fullURL = BaseURL + endpoint
        
        guard let queryItems = queryItems else {
            return URL(string: fullURL)
        }

        var components = URLComponents(string: fullURL)
        components?.queryItems = queryItems
        
        return components?.url
    }
}
