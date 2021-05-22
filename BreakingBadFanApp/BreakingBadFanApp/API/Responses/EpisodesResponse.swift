//
//  EpisodesResponse.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-26.
//

import Foundation

class Season {
    var season: String
    var episodes: [Episode]
    
    init(season: String, episodes: [Episode]) {
        self.season = season
        self.episodes = episodes
    }
}

struct Episode: Decodable, Hashable {
    let season: String
    let episodeNumber: String
    let episodeID: Int
    let episodeTitle: String
    let airDate: String
    let characters: [String]
    
    var convertedAirDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.date(from: airDate) ?? .distantPast
    }
    
    private enum CodingKeys: String, CodingKey {
        case season
        case episodeNumber = "episode"
        case episodeID = "episode_id"
        case episodeTitle = "title"
        case airDate = "air_date"
        case characters
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        season = try values.decode(String.self, forKey: .season)
        episodeNumber = try values.decode(String.self, forKey: .episodeNumber)
        episodeID = try values.decode(Int.self, forKey: .episodeID)
        episodeTitle = try values.decode(String.self, forKey: .episodeTitle)
        airDate = try values.decode(String.self, forKey: .airDate)
        characters = try values.decode([String].self, forKey: .characters)
    }
}


