//
//  APIManager.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-26.
//

import Foundation

struct APIManager {
    private let decoder = JSONDecoder()
    
//MARK: - Get episodes -
    
    func getEpisodes(_ completion: @escaping (Result<[Episode], APIError>) -> Void) {
        guard
            let url = APIEndpoint.getEpisodes.url
        else {
            completion(.failure(.failedURLCreation))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else {
                completion(.failure(.failedRequest))
                return
            }
            
            guard
                let episodesResponse = try? decoder.decode([Episode].self, from: data)
            else {
                completion(.failure(.unexpectedDataFormat))
                return
            }
            completion(.success(episodesResponse))
        }
        task.resume()
    }
    
//MARK: - Get characters -
    
    func getCharacters(_ completion: @escaping (Result<[Character], APIError>) -> Void) {
        guard let url = APIEndpoint.getCharacters.url else {
            completion(.failure(.failedURLCreation))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else {
                completion(.failure(.failedRequest))
                return
            }
            
            guard
                let charactersResponse = try? decoder.decode([Character].self, from: data)
            else {
                completion(.failure(.unexpectedDataFormat))
                return
            }
            completion(.success(charactersResponse))
        }
        task.resume()
    }
    
//MARK: - Get character by name -
    
    func getCharacterByName(name: String, _ completion: @escaping (Result<[Character], APIError>) -> Void) {
        guard
            let url = APIEndpoint.getCharacter(name: name).url
        else {
            completion(.failure(.failedURLCreation))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else {
                completion(.failure(.failedRequest))
                return
            }

            guard
                let characterResponse = try? decoder.decode([Character].self, from: data)
            else {
                completion(.failure(.unexpectedDataFormat))
                return
            }
            completion(.success(characterResponse))
        }
        task.resume()
    }
    
//MARK: - Get quotes -
    
    func getQuotes(author: String, _ completion: @escaping (Result<[Quote], APIError>) -> Void) {
        guard
            let url = APIEndpoint.getQuotes(author: author).url
        else {
            completion(.failure(.failedURLCreation))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else {
                completion(.failure(.failedRequest))
                return
            }
            
            guard
                let quotesResponse = try? decoder.decode([Quote].self, from: data)
            else {
                completion(.failure(.unexpectedDataFormat))
                return
            }
            completion(.success(quotesResponse))
        }
        task.resume()
    }
    
//MARK: - Get random quote -
    
    func getRandomQuote(_ completion: @escaping (Result<[Quote], APIError>) -> Void) {
        guard
            let url = APIEndpoint.getRandomQuote.url
        else {
            completion(.failure(.failedURLCreation))
            return
        }

        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else {
                completion(.failure(.failedRequest))
                return
            }
            
            guard
                let randomQuoteResponse = try? decoder.decode([Quote].self, from: data)
            else {
                completion(.failure(.unexpectedDataFormat))
                return
            }
            completion(.success(randomQuoteResponse))
        }
        task.resume()
    }
}



