//
//  FilterEpisodesPopUpViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-27.
//

import UIKit

protocol FilterEpisodeSelectionDelegate: AnyObject {
    func didApplyEpisodeFilter(season: String?, startDate: String?, character: Set<String>?)
//    func didApplyEpisodeDateFilter()
}

class FilterEpisodesPopUpViewController: ParentViewController {
    
    weak var filterEpisodeSelectionDelegate: FilterEpisodeSelectionDelegate?
    private var apiManager = APIManager()
    var characters: [String] = []
    var selectedCharacters: Set<String> = []
    var selectedDate: String?
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var seasonNoTextField: UITextField!
 
    @IBOutlet weak var airDatePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupTableView()
        loadCharactersAlphabetically()
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
//        filterEpisodeSelectionDelegate?.didApplyEpisodeDateFilter(startDate: selectedDate)
        filterEpisodeSelectionDelegate?.didApplyEpisodeFilter(season: seasonNoTextField.text, startDate: selectedDate, character: selectedCharacters)
        print("Season selected: \(seasonNoTextField.text)")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueSelected(_ sender: UIDatePicker) {
        
        print("Date selected \(sender.date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedDate = dateFormatter.string(from: sender.date)
        selectedDate = formattedDate
        
        print("Date converted to: \(formattedDate). selectedDate: \(String(describing: selectedDate))")
    }
}

//MARK: - Set up table view -

extension FilterEpisodesPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.nib, forCellReuseIdentifier: "CharacterCell")
        tableView.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Characters"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        guard let characterCell = cell as? CharacterTableViewCell else { return cell }
        characterCell.configureCell(characterName: characters[indexPath.row])
        
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let selectedCharacterName = characters[indexPath.row]
        
        if cell.isSelected {
            selectedCharacters.insert(selectedCharacterName)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCharacterName = characters[indexPath.row]
        
        if selectedCharacters.contains(deselectedCharacterName) {
            selectedCharacters.remove(deselectedCharacterName)
        }
    }
}

//MARK: - Configure view -
extension FilterEpisodesPopUpViewController {
    
    private func configureView() {
        popUpView.layer.cornerRadius = 8
        tableView.layer.cornerRadius = 8
        airDatePicker.layer.cornerRadius = 16
        airDatePicker.setValue(UIColor.white, forKey: "textColor")
    }
    
    private func loadCharactersAlphabetically() {
        characters.sort { $0 < $1 }
    }
}
