//
//  CharactersPreviewViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-28.
//

import UIKit

class CharactersPreviewViewController: ParentViewController {

    private var characters: [Character] = []
    private var filteredCharacters: [Character] = []
    private var selectedCharacter: Character?
    private var allSeasons: [Int] = []
    var characterGroups: [CharacterGroup] = []

    private var apiManager = APIManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var filterCharactersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        loadAllSeasons()
    }
    
    @IBAction func filterCharactersButtonTapped(_ sender: Any) {
        let filterCharactersPopUpViewController = FilterCharactersPopUpViewController()
        filterCharactersPopUpViewController.filterCharacterSelectionDelegate = self
        filterCharactersPopUpViewController.seasons = allSeasons
        present(filterCharactersPopUpViewController, animated: true, completion: nil)
    }
    
    @IBAction func resetFilterCharactersButtonTapped(_ sender: UIButton) {
        characters = []
        allSeasons = []
        characterGroups = []
        loadCharacters()
    }
}
//MARK: - Load characters -

extension CharactersPreviewViewController {
    
    private func loadCharacters() {
        activityIndicatorView.startAnimating()
        
        apiManager.getCharacters { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.characters = response
            self.loadAllSeasons()
            self.loadCharactersAlphabetically()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
            case .failure:
                self.showAlert(title: APIError.failedCharacterRequest.errorDescription)
                DispatchQueue.main.async {
                self.filterCharactersButton.isHidden = true
                self.activityIndicatorView.isHidden = true
                }
            }
        }
    }
    
    private func loadCharactersAlphabetically() {
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
    }
    
    private func loadAllSeasons() {
        for character in characters {
            allSeasons += character.appearedInSeason
            allSeasons = allSeasons.removingDuplicates()
        }
    }
}
//MARK: - Set up table view -

extension CharactersPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return characterGroups.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.tableView(tableView, numberOfRowsInSection: section) > 0 ? "Characters" : nil
        return characterGroups[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        characters.count
        characterGroups[section].characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath)
//        let character = characters[indexPath.row]
        let character = characterGroups[indexPath.section].characters[indexPath.row]

        cell.textLabel?.text = character.name
        return cell
    }
}
//MARK: - Navigation -

extension CharactersPreviewViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let character = characters[indexPath.row]
        let character = characterGroups[indexPath.section].characters[indexPath.row]
        selectedCharacter = character
        performSegue(withIdentifier: "showCharactersDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? CharacterDetailsViewController {
            destinationViewController.selectedCharacterName = selectedCharacter?.name
        }
    }
}
//MARK: - Characters filter delegate implementation -

extension CharactersPreviewViewController: FilterCharacterSelectionDelegate {

    func didApplyCharacterFilter(status: Bool, season: Set<Int>) {
        characterGroups = []
        let characterStatus = status ? "Alive" : "Deceased"

        if season == [] {
            characters = characters.filter { $0.status == characterStatus }
        } else {
            characters = characters
                .filter { $0.appearedInSeason.contains(where: { season.contains($0) }) }
                .filter { $0.status == characterStatus }
        }
        characters = characters.removingDuplicates()
        loadCharactersAlphabetically()
        tableView.reloadData()
    }
}
