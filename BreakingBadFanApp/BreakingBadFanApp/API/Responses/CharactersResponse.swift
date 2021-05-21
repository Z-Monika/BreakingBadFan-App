//
//  CharactersResponse.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-28.
//

import UIKit

struct Character: Decodable, Hashable {
    let name: String
    let birthday: String
    let status: String
    let appearedInSeason: [Int]
    let image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case status
        case appearedInSeason = "appearance"
        case image = "img"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        birthday = try values.decode(String.self, forKey: .birthday)
        status = try values.decode(String.self, forKey: .status)
        appearedInSeason = try values.decode([Int].self, forKey: .appearedInSeason)
        
        let imageUrlString = try values.decode(String.self, forKey: .image)
        let imageUrl = URL(string: imageUrlString)!
        
        if let imageData = try? Data(contentsOf: imageUrl) {
            image = UIImage(data: imageData)
        } else {
            image = nil
        }
    }
}
