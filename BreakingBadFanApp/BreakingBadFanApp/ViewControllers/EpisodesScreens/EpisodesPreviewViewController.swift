//
//  EpisodesViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-25.
//

import UIKit

class EpisodesPreviewViewController: ParentViewController {
    
    private let dateFormatter = DateFormatter()
    private var apiManager = APIManager()
    private var episodes: [Episode] = []
    private var seasons: [Season] = []
    private var allCharacters: [String] = []
    private var selectedEpisode: Episode?
    private var filteredEpisodes: [Episode] = []
    
    private var firstEpisodeDate: Date {
        guard let firstDate = episodes.first?.convertedAirDate else {
            return EpisodesManager.firstAirDate
        }
        return firstDate
    }
    
    private var lastEpisodeDate: Date {
        guard let lastDate = episodes.last?.convertedAirDate else {
            return EpisodesManager.lastAirDate
        }
        return lastDate
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var filterEpisodesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadEpisodes()
        loadSeasons()
        getFirstEpisodeDate()
        getLastEpisodeDate()
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
        seasons = EpisodesManager.groupEpisodesBySeason(episodes: episodes)
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
    func didApplyEpisodeFilter(season: String?, dateFrom: String?, dateUntil: String?, character: Set<String>?) {
        seasons = []
        
        episodes = EpisodesManager.applyFilters(episodesToFilter: episodes, season: season, dateFrom: dateFrom, dateUntil: dateUntil, characters: character)
                
        episodes = episodes.removingDuplicates()
        loadSeasons()

        tableView.reloadData()
    }
}
//MARK: - Helpers -

extension EpisodesPreviewViewController {
    private func getFirstEpisodeDate() {
        EpisodesManager.firstAirDate = firstEpisodeDate
    }
    
    private func getLastEpisodeDate() {
        EpisodesManager.lastAirDate = lastEpisodeDate
    }
}
