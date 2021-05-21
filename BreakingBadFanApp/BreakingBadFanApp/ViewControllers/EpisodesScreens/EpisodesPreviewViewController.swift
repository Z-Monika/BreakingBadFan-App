//
//  EpisodesViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-25.
//

import UIKit

class EpisodesPreviewViewController: ParentViewController {
    
    private var episodes: [Episode] = []
    private var seasons: [Season] = []
    private var allCharacters: [String] = []
    private var selectedEpisode: Episode?
    private var episodesByDate: [Episode] = []
    
    private let dateFormatter = DateFormatter()
    private var apiManager = APIManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var filterEpisodesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadEpisodes()
        loadSeasons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        loadAllCharacters()
    }

    @IBAction func filterEpisodesButtonTapped(_ sender: UIButton) {
        let filterEpisodesPopUpViewController = FilterEpisodesPopUpViewController()
        filterEpisodesPopUpViewController.filterEpisodeSelectionDelegate = self
        filterEpisodesPopUpViewController.characters = allCharacters
        present(filterEpisodesPopUpViewController, animated: true, completion: nil)
    }
    
    @IBAction func resetFilterEpisodesButtonTapped(_ sender: UIButton) {
        episodes = []
        seasons = []
        loadEpisodes()
        loadSeasons()
    }
}

//MARK: - Load episodes -

extension EpisodesPreviewViewController {
    
    private func loadEpisodes() {
        activityIndicatorView.startAnimating()

        apiManager.getEpisodes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.episodes = response
                self.loadSeasons()
                self.loadAllCharacters()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicatorView.stopAnimating()
                }
            case .failure:
                self.showAlert(title: APIError.failedEpisodeRequest.errorDescription)
                DispatchQueue.main.async {
                self.filterEpisodesButton.isHidden = true
                self.activityIndicatorView.isHidden = true
                }
            }
        }
    }
}

//MARK: - Set up table view -
extension EpisodesPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        seasons.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableView(tableView, numberOfRowsInSection: section) > 0 ? "Season " + seasons[section].season : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath)
        let episode = seasons[indexPath.section].episodes[indexPath.row]
        cell.textLabel?.text = episode.episodeTitle
        cell.detailTextLabel?.text = String("Episode No. " + episode.episodeNumber)
        return cell
    }
}

//MARK: - Table Sections -

extension EpisodesPreviewViewController {
    
    private func loadSeasons() {
        
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
    }
    
    private func loadAllCharacters() {
        
        for episode in episodes {
            allCharacters += episode.characters
            allCharacters = allCharacters.removingDuplicates()
        }
    }
}

// MARK: - Navigation -

extension EpisodesPreviewViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = seasons[indexPath.section].episodes[indexPath.row]
        selectedEpisode = episode
        performSegue(withIdentifier: "showEpisodesDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destinationViewController = segue.destination as? EpisodeDetailsViewController {
        destinationViewController.selectedEpisode = selectedEpisode
        }
    }
}

//MARK: - Episodes filter delegate implementation -

extension EpisodesPreviewViewController: FilterEpisodeSelectionDelegate {
    
    func didApplyEpisodeFilter(season: String?, startDate: String?, character: Set<String>?) {
        if let character = character,
           let season = season {
    
            seasons = seasons.filter { $0.season == season }
            episodes = episodes
                .filter { $0.characters.contains(where: { character.contains($0) })  }

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
            episodes = episodes.removingDuplicates()
            seasons.sort { $0.season < $1.season }
            tableView.reloadData()
        }
    }
    
    /*
    func didApplyEpisodeDateFilter(startDate: String?, endDate: String?) {
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        if let startDate = startDate,
           let endDate = endDate,
           let formattedStartDate = dateFormatter.date(from: startDate),
           let formattedEndDate = dateFormatter.date(from: endDate) {
            
            let range = formattedStartDate...formattedEndDate
            
            for episode in episodes {
                var seasonNumber = episode.season
                
                if seasonNumber == " 1" {
                    seasonNumber = "1"
                }
                
                guard let episodeAirDate = dateFormatter.date(from: episode.airDate) else { continue }
                
                if range.contains(episodeAirDate) {
                    episodesByDate.append(episode)
                }
                episodes = episodesByDate

                if let season = seasons.first(where: { $0.season == seasonNumber }) {
                    season.episodes.append(episode)
                } else {
                    let season = Season(season: seasonNumber, episodes: [episode])
                    seasons.append(season)
                }
            }
            episodes = episodes.removingDuplicates()
            seasons.sort { $0.season < $1.season }
            tableView.reloadData()
        }
    } */
}
