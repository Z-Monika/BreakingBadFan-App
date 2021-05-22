//
//  EpisodesManager.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-04.
//

import Foundation

class EpisodesManager {
    
    static var firstAirDate = Date(timeIntervalSince1970: 1199222427)
    static var lastAirDate = Date(timeIntervalSince1970: 1380486027)
    
    static func groupEpisodesBySeason(episodes: [Episode]) -> [Season] {
        
        var seasons: [Season] = []
        
        for episode in episodes {
            var seasonNumber = episode.season
            
            if seasonNumber == " 1" {
                seasonNumber = "1"
            }
            
            if let season = seasons.first(where: { $0.season == seasonNumber}) {
                season.episodes.append(episode)
            } else {
                let season = Season(season: seasonNumber, episodes: [episode])
                seasons.append(season)
            }
        }
        seasons.sort { $0.season < $1.season }
        
        return  seasons
    }
    
    static func applyFilters(episodesToFilter: [Episode], season: String?, dateFrom: String?, dateUntil: String?, characters: Set<String>?) -> [Episode] {

        var filteredEpisodes: [Episode] = episodesToFilter
        
        if season != nil {
            filteredEpisodes = filterBySeason(season: season, episodes: episodesToFilter)
        }
        
        if dateFrom != nil {
            filteredEpisodes = filterFromDate(dateFrom: dateFrom, episodes: episodesToFilter)
        }
        
        if dateUntil != nil {
            filteredEpisodes = filterUntilDate(dateUntil: dateUntil, episodes: episodesToFilter)
        }
        
        if characters?.count != 0 {
            filteredEpisodes = filterByCharacters(selectedCharacters: characters, episodes: episodesToFilter)
        }

        filteredEpisodes.removeDuplicates()
        
        return filteredEpisodes
    }
    
    private static func filterBySeason(season: String?, episodes: [Episode]) -> [Episode] {
        guard let season = season else { return [] }
        
        let filteredEpisodes = episodes.filter { $0.season == season }
        
        return filteredEpisodes
    }
    
    private static func filterFromDate(dateFrom: String?, episodes: [Episode]) -> [Episode]  {
        guard let dateFrom = dateFrom else { return [] }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let convertedDateFrom = dateFormatter.date(from: dateFrom) ?? .distantPast
        
        let filteredEpisodes = episodes.filter {
            $0.convertedAirDate <= convertedDateFrom
        }
        
        return filteredEpisodes
    }
    
    private static func filterUntilDate(dateUntil: String?, episodes: [Episode]) -> [Episode]  {
        guard let dateUntil = dateUntil else { return [] }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let convertedDateUntil = dateFormatter.date(from: dateUntil) ?? .distantPast
        
        let filteredEpisodes = episodes.filter {
            $0.convertedAirDate >= convertedDateUntil
        }
        
        return filteredEpisodes
    }
    
    private static func filterByCharacters(selectedCharacters: Set<String>?, episodes: [Episode]) -> [Episode]  {
        guard
            let selectedCharacters = selectedCharacters,
            !selectedCharacters.isEmpty
        else { return [] }
        
        let filteredEpisodes = episodes
            .filter { $0.characters.contains(where: { selectedCharacters.contains($0) })  }
        
        
        return filteredEpisodes
    }
}


