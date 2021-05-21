//
//  QuoteManager.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-04.
//

import Foundation

class QuoteManager {
    static private let apiManager = APIManager()
    static private let userDefaultsManager = UserDefaultsManager()
}

//MARK: - Favorites quotes -
extension QuoteManager {
    
    static func saveFavoriteQuote(_ quote: Quote) {
        guard
            let username = UserDefaultsManager.loggedInAccount?.username
        else {
            return
        }
        
        let quotes = UserDefaultsManager.quotes
        
        let favoriteQuoteToSave = FavoriteQuote(username: username, quote: quote)

        if quotes == nil {
            UserDefaultsManager.saveQuote(favoriteQuoteToSave)
        }
        
        if
            let quotes = quotes,
            quotes.firstIndex(where: { $0.username == username && $0.quote.quoteId == quote.quoteId }) == nil {
            UserDefaultsManager.saveQuote(favoriteQuoteToSave)
        }
    }

    static func deleteFavoriteQuote(_ quote: Quote, username: String) {
        guard let quotes = UserDefaultsManager.quotes else { return }
        
        if
            let index = quotes
            .firstIndex(where: { $0.username == username && $0.quote.quoteId == quote.quoteId }) {
            UserDefaultsManager.quotes?.remove(at: index)
        }
    }
}

//MARK: - User quotes -

extension QuoteManager {
    
     static var userFavoriteQuotes: [Quote] {
        guard let quotes = UserDefaultsManager.quotes else { return [] }
        
        let userQuotes = quotes
            .filter { $0.username == UserDefaultsManager.loggedInAccount?.username }
            .map { $0.quote }
            .removingDuplicates()
        return userQuotes
    }
    
    static func isQuoteFavorite(_ quote: Quote) -> Bool {
        userFavoriteQuotes.contains(quote)
    }
}

//MARK: - Top 3 quotes -
extension QuoteManager {
    
    static var topThreeQuotes: (threeQuotes: [Quote], threeQuotesCount: [Int]) {
        guard
            let quotes = UserDefaultsManager.quotes
        else {
            return (threeQuotes: [], threeQuotesCount: [])
        }
        
        var count: [Quote: Int] = [:]
        
        quotes.forEach { count[$0.quote] = (count[$0.quote] ?? 0) + 1 }
    
        let threeQuotes = count
            .sorted(by: { $0.value > $1.value })
            .prefix(3)
            .map { $0.key }
        
        let threeQuotesCount = count
            .sorted(by: { $0.value > $1.value })
            .prefix(3)
            .map { $0.value }

        return (threeQuotes: threeQuotes, threeQuotesCount: threeQuotesCount)
    }
    
//    static var topThreeQuotesCount: [Int] {
//        guard let quotes = UserDefaultsManager.quotes else { return [] }
//        var count: [Quote: Int] = [:]
//        
//        quotes.forEach { count[$0.quote] = (count[$0.quote] ?? 0) + 1 }
//    
//        let threeQuotesCount = count
//            .sorted(by: { $0.value > $1.value })
//            .prefix(3)
//            .map { $0.value }
//
//        return threeQuotesCount
//    }
}




