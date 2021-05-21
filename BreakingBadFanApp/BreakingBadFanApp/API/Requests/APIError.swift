//
//  APIError.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-26.
//

import Foundation

enum APIError: Error {
    case failedURLCreation
    case failedRequest
    case failedResponse
    case parsingFailed
    case unexpectedDataFormat
    case failedEpisodeRequest
    case failedCharacterRequest
    case failedCharacterDetailsRequest
    case failedQuoteRequest
    case failedRandomQuoteRequest
    
    var errorDescription: String {
        switch self {
        case .failedURLCreation:
            return "Failed URL creation"
        case .failedRequest:
            return "Failed request"
        case .failedResponse:
            return "Failed response"
        case .parsingFailed:
            return "Parsing failed"
        case .unexpectedDataFormat:
            return "Unexpected data format"
        case .failedEpisodeRequest:
            return "Sorry..Something went wrong while loading episodes.."
        case .failedCharacterRequest:
            return "Sorry..Something went wrong while loading characters.."
        case .failedCharacterDetailsRequest:
            return "Sorry..Something went wrong while loading character details.."
        case .failedQuoteRequest:
            return "Sorry..Something went wrong while loading quotes.."
        case .failedRandomQuoteRequest:
            return "Sorry..Something went wrong while loading a random quote.."
        }
    }
}
