//
//  CharacterDetailsViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-28.
//

import UIKit

protocol QuoteSaveDelegate: AnyObject {
    func didSaveFavoriteQuote()
}

class CharacterDetailsViewController: ParentViewController {
    
    weak var quoteSaveDelegate: QuoteSaveDelegate?
    private var quotes: [Quote] = []
    private var apiManager = APIManager()
    private var savedQuotes = UserDefaultsManager.quotes
    private var quotesTableViewCell = QuotesTableViewCell()
    private var selectedCharacter: Character?
    private var character: [Character] = []
    var selectedCharacterName: String?
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthdayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadCharacterDetails()
        loadQuotes()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        quoteSaveDelegate?.didSaveFavoriteQuote()
    }
}

//MARK: - Load quotes -

extension CharacterDetailsViewController {
    
    private func loadCharacterDetails() {
        guard let selectedCharacterName = selectedCharacterName else { return }
        
        apiManager.getCharacterByName(name: selectedCharacterName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.character = response
                DispatchQueue.main.async {
                    self.configureView()
                }
            case .failure:
                self.showAlert(title: APIError.failedCharacterDetailsRequest.errorDescription)
                DispatchQueue.main.async {
                    self.activityIndicatorView.isHidden = true
                }
            }
        }
    }
    
    private func loadQuotes() {
        guard let selectedCharacterName = selectedCharacterName else { return }
        activityIndicatorView.startAnimating()
        correctAPINamingMistakes()
        
        apiManager.getQuotes(author: selectedCharacterName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.quotes = response
                DispatchQueue.main.async {
                    self.showNoQuotesAlert()
                    self.configureView()
                    self.tableView.reloadData()
                    self.activityIndicatorView.stopAnimating()
                }
            case .failure:
                self.showAlert(title: APIError.failedCharacterDetailsRequest.errorDescription)
            }
        }
    }
}

//MARK: - Configure view -

extension CharacterDetailsViewController {
    
    private func configureView() {
        guard let firstCharacterName = character.first?.name,
              let firstCharacterBirthday = character.first?.birthday,
              let firstCharacterImage = character.first?.image
        else { return }
        
        setBackgroundImage(with: firstCharacterImage)
        setCharacterNameLabel(with: firstCharacterName)
        setCharacterBirthdayLabel(with: firstCharacterBirthday)
    }
    
    private func setBackgroundImage(with image: UIImage){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setCharacterNameLabel(with name: String) {
        characterNameLabel.text = name
    }
    
    private func setCharacterBirthdayLabel(with birthdate: String) {
        if birthdate == "Unknown" {
            characterBirthdayLabel.text = "Date of birth unknown"
        } else {
            characterBirthdayLabel.text = "Born on \(birthdate)"
        }
    }
    
    private func showNoQuotesAlert() {
        if quotes.count == 0 {
            showAlert(title: "Sorry..No quotes found for this character!")
        }
    }
}

//MARK: - Set up table view -

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuotesTableViewCell.nib, forCellReuseIdentifier: "QuotesCell")
        tableView.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableView(tableView, numberOfRowsInSection: section) > 0 ? "Character quotes" : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotesCell", for: indexPath)
        guard let quoteCell = cell as? QuotesTableViewCell else { return cell }
        let quoteForCell = quotes[indexPath.row]
        
        quoteCell.configureCell(quote: quotes[indexPath.row].quote, favoriteCount: nil)
        quoteCell.isFavoriteQuote = QuoteManager.isQuoteFavorite(quoteForCell)
        
        return quoteCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuote = quotes[indexPath.row]
        saveFavoriteQuotes(selectedQuote)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedQuote = quotes[indexPath.row]
        deleteQuoteFromFavorties(deselectedQuote)
    }
}

//MARK: - Favorite quote functionality -

extension CharacterDetailsViewController {
    
    private func saveFavoriteQuotes(_ quote: Quote) {
        QuoteManager.saveFavoriteQuote(quote)
        quoteSaveDelegate?.didSaveFavoriteQuote()
    }
    
    private func deleteQuoteFromFavorties(_ quote: Quote) {
        if let loggedInAccount = UserDefaultsManager.loggedInAccount {
            QuoteManager.deleteFavoriteQuote(quote, username: loggedInAccount.username)
        }
        quoteSaveDelegate?.didSaveFavoriteQuote()
    }
    
    private func isQuoteFavorite() {
        for quote in quotes {
            if QuoteManager.isQuoteFavorite(quote) {
                quotesTableViewCell.favoriteImageView?.image = UIImage(named: "filledHeart")
            } else if !QuoteManager.isQuoteFavorite(quote) {
                quotesTableViewCell.favoriteImageView?.image = UIImage(named:  "clearHeart")
            }
        }
    }
}

//MARK: - Correct API naming -

extension CharacterDetailsViewController {
    
    private func correctAPINamingMistakes() {
        if selectedCharacterName == "Henry Schrader" {
            selectedCharacterName = "Hank Schrader"
        }
    }
}
