//
//  EpisodeDetailsViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-25.
//

import UIKit

class EpisodeDetailsViewController: ParentViewController {
    
    private var selectedCharacter: Character?
    private var selectedCharacterName: String?
    var selectedEpisode: Episode?
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeSeasonAndNumberLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
}

//MARK: - Configure view -

extension EpisodeDetailsViewController {
    
    private func configureView() {
        guard
            let episodeTitle = selectedEpisode?.episodeTitle,
            let episodeSeason = selectedEpisode?.season,
            let episodeNumber = selectedEpisode?.episodeNumber,
            let episodeAirDate = selectedEpisode?.airDate
        else {
            return
        }
        
        episodeTitleLabel.text = "\"\(episodeTitle)\""
        episodeSeasonAndNumberLabel.text = "Season No. \(episodeSeason) | Episode No. \(episodeNumber)"
        episodeAirDateLabel.text = "Aired on: \(episodeAirDate)"
    }
}

//MARK: - Set up table view -

extension EpisodeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Episode characters"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedEpisode = selectedEpisode else { return 0 }
        return selectedEpisode.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCharactersCell", for: indexPath)
        let character = selectedEpisode?.characters[indexPath.row]
        cell.textLabel?.text = character
        return cell
    }
}

//MARK: - Navigation -

extension EpisodeDetailsViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = selectedEpisode?.characters[indexPath.row]
        selectedCharacterName = character
        performSegue(withIdentifier: "showCharactersDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? CharacterDetailsViewController {
            correctAPINamingMistakes()
            destinationViewController.selectedCharacterName = selectedCharacterName
        }
    }
}

//MARK: - Correct API naming -

extension EpisodeDetailsViewController {
    private func correctAPINamingMistakes() {
        if selectedCharacterName == "Krazy-8" {
            selectedCharacterName = "Domingo Molina"
        } else if selectedCharacterName == "Hank Schrader" {
            selectedCharacterName = "Henry Schrader"
        }
    }
}
