//
//  FilterCharactersPopUpViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-28.
//

import UIKit

protocol FilterCharacterSelectionDelegate: AnyObject {
   func didApplyCharacterFilter(status: Bool, season: Set<Int>)
}

class FilterCharactersPopUpViewController: ParentViewController {
    
    weak var filterCharacterSelectionDelegate: FilterCharacterSelectionDelegate?
    private var selectedSeasons: Set<Int> = []
    var seasons: [Int] = []

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var characterStatusSwitch: UISwitch!
    @IBOutlet weak var characterStatusControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupTableView()
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        filterCharacterSelectionDelegate?.didApplyCharacterFilter(status: isAlive(characterStatus: characterStatusControl), season: selectedSeasons)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Set up table view -

extension FilterCharactersPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SeasonTableViewCell.nib, forCellReuseIdentifier: "SeasonCell")
        tableView.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Seasons"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell", for: indexPath)
        guard let seasonCell = cell as? SeasonTableViewCell else { return cell }
        
        seasonCell.configureCell(seasonNumber: seasons[indexPath.row])
        return seasonCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let selectedSeasonNumber = seasons[indexPath.row]
        
        if cell.isSelected {
            selectedSeasons.insert(selectedSeasonNumber)
        }
        print("selectedSeasons: \(selectedSeasons)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedSeasonNumber = seasons[indexPath.row]

        if selectedSeasons.contains(deselectedSeasonNumber) {
            selectedSeasons.remove(deselectedSeasonNumber)
        }
        print("selectedSeasons: \(selectedSeasons)")

    }
}

//MARK: - Configure view -

extension FilterCharactersPopUpViewController {
    
    private func configureView() {
        popUpView.layer.cornerRadius = 8
        tableView.layer.cornerRadius = 8
    }
    
    private func isAlive(characterStatus: UISegmentedControl) -> Bool {
        return characterStatus.selectedSegmentIndex == 0 ? true : false
    }
}
