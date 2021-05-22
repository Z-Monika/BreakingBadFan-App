//
//  FilterEpisodesPopUpViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-27.
//

import UIKit

protocol FilterEpisodeSelectionDelegate: AnyObject {
    func didApplyEpisodeFilter(season: String?, dateFrom: String?, dateUntil: String?, character: Set<String>?)
}

class FilterEpisodesPopUpViewController: ParentViewController {
    
    weak var filterEpisodeSelectionDelegate: FilterEpisodeSelectionDelegate?
    private var apiManager = APIManager()
    var characters: [String] = []
    var selectedCharacters: Set<String> = []
    var selectedDateFrom: String?
    var selectedDateUntil: String?

    private lazy var toolBar = FilterDateToolbar()
    private lazy var datePicker = FilterDatePicker()
    
    @IBOutlet weak var dateFromButton: UIButton!
    @IBOutlet weak var dateUntilButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var seasonNoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupTableView()
        loadCharactersAlphabetically()
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        filterEpisodeSelectionDelegate?.didApplyEpisodeFilter(season: seasonNoTextField.text, dateFrom: selectedDateFrom, dateUntil: selectedDateUntil, character: selectedCharacters)

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateFromButtonTapped(_ sender: Any) {
        showDateFromPickerView()
    }
    
    @IBAction func dateUntilButtonTapped(_ sender: Any) {
        showDateUntilFromPickerView()
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

//MARK: - Set up date picker view
extension FilterEpisodesPopUpViewController {
    private func showDateFromPickerView() {
        setDateRange()
        
        self.view.addSubview(datePicker)
        self.view.addSubview(toolBar)

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dateFromPickerDoneButtonPressed)
        )

        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(dateFromPickerCancelButtonPressed)
        )

        doneButton.tintColor = .white
        cancelButton.tintColor = .white

        toolBar.items = [
            doneButton,
            UIBarButtonItem(systemItem: .flexibleSpace),
            cancelButton
        ]
    }
    
    @objc func dateFromPickerDoneButtonPressed() {
        let selectedValue = datePicker.date
        let dateFormater = setDateFormater()
        selectedDateFrom = dateFormater.string(from: selectedValue)
        dateFromButton.setTitle(selectedDateFrom, for: .normal)
        removeFromSuperView()
    }
    
    @objc func dateFromPickerCancelButtonPressed() {
        selectedDateFrom = nil
        dateFromButton.setTitle("Date from", for: .normal)
        removeFromSuperView()
    }
    
    private func showDateUntilFromPickerView() {
        setDateUntilPickerDateRange()
        
        self.view.addSubview(datePicker)
        self.view.addSubview(toolBar)

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dateUntilPickerDoneButtonPressed)
        )

        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(dateUntilPickerCancelButtonPressed)
        )

        doneButton.tintColor = .white
        cancelButton.tintColor = .white

        toolBar.items = [
            doneButton,
            UIBarButtonItem(systemItem: .flexibleSpace),
            cancelButton
        ]
    }
    
    @objc func dateUntilPickerDoneButtonPressed() {
        let selectedValue = datePicker.date
        let dateFormater = setDateFormater()
        selectedDateUntil = dateFormater.string(from: selectedValue)
        dateUntilButton.setTitle(selectedDateUntil, for: .normal)
        removeFromSuperView()
    }
    
    @objc func dateUntilPickerCancelButtonPressed() {
        selectedDateUntil = nil
        dateUntilButton.setTitle("Date until", for: .normal)
        removeFromSuperView()
    }
    
    private func setDateRange() {
        datePicker.minimumDate = EpisodesManager.firstAirDate
        datePicker.maximumDate = EpisodesManager.lastAirDate
    }
    
    private func setDateUntilPickerDateRange() {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy"
        
        if let selectedDateFrom = selectedDateFrom {
            datePicker.minimumDate = dateFormater.date(from: selectedDateFrom)
        } else {
            datePicker.minimumDate = EpisodesManager.firstAirDate
        }
        datePicker.maximumDate = EpisodesManager.lastAirDate
    }
    
    private func setDateFormater() -> DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy"
        return dateFormater
    }
    
    private func removeFromSuperView() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
}
//MARK: - Configure view -
extension FilterEpisodesPopUpViewController {
    
    private func configureView() {
        popUpView.layer.cornerRadius = 8
        tableView.layer.cornerRadius = 8
        dateFromButton.layer.cornerRadius = 16
        dateUntilButton.layer.cornerRadius = 16
    }
    
    private func loadCharactersAlphabetically() {
        characters.sort { $0 < $1 }
    }
}
