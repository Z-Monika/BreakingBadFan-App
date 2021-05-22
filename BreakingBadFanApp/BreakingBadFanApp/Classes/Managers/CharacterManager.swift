//
//  CharacterManager.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-04.
//

import Foundation

class CharacterGroup {
    var title: String
    var characters: [Character]

    init(title: String, characters: [Character]) {
        self.title = title
        self.characters = characters
    }
}

class CharacterManager {
    static func groupCharactersAlphabetically(characters: [Character]) -> [CharacterGroup] {
        var characterGroups: [CharacterGroup] = []

        for character in characters {
            let firstLetter = String(character.name.first!)
            if let group = characterGroups.first(where: { $0.title == firstLetter }) {
                group.characters.append(character)
            } else {
                let group = CharacterGroup(title: firstLetter, characters: [character])
                characterGroups.append(group)
            }
        }
        characterGroups.sort { $0.title < $1.title }
        
        return characterGroups
    }
    
    static func applyFilters(status: Bool?, seasons: Set<Int>?, charactersToFilter: [Character]) -> [Character] {
        var filteredCharacters: [Character] = charactersToFilter

        if status != nil {
            filteredCharacters = filterByCharacterStatus(characters: charactersToFilter, status: status)
        }
        
        if seasons?.count != 0 {
            filteredCharacters = filterBySeason(character: charactersToFilter, seasons: seasons)
        }
        
        filteredCharacters = filteredCharacters.removingDuplicates()
        
        return filteredCharacters
    }
    
    private static func filterByCharacterStatus(characters: [Character], status: Bool?) -> [Character] {
        guard let status = status else { return [] }
        let characterStatus = status ? "Alive" : "Deceased"
        let filteredCharacters = characters.filter { $0.status == characterStatus }
        
        return filteredCharacters
    }
    
    private static func filterBySeason(character: [Character], seasons: Set<Int>?)  -> [Character] {
        guard let seasons = seasons else { return [] }
        let filteredtCharacters = character.filter { $0.appearedInSeason.contains(where: { seasons.contains($0) }) }
        
        return filteredtCharacters
    }
}
