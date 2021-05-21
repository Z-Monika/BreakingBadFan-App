//
//  QuotesViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-04.
//

import UIKit

class QuotesViewController: ParentViewController {
    
    private var topThreeQuotes: [Quote] = QuoteManager.topThreeQuotes.threeQuotes
    private var topThreeQuotesCount: [Int] = QuoteManager.topThreeQuotes.threeQuotesCount
    private var userFavoriteQuotes: [Quote] = QuoteManager.userFavoriteQuotes
    private var randomQuote: [Quote] = []
    private var apiManager = APIManager()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadRandomQuote()
    }
}

//MARK: - Load random quote -
extension QuotesViewController  {
    
    private func loadRandomQuote() {
        apiManager.getRandomQuote { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.randomQuote = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            case .failure:
                self.showAlert(title: APIError.failedRandomQuoteRequest.errorDescription)
            }
        }
    }
}

//MARK: - Set up table view -

extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuotesTableViewCell.nib, forCellReuseIdentifier: "QuotesCell")
        tableView.allowsMultipleSelection = true
    }
    
    enum TableSection: Int {
        case topThreeQuotes, userFavoriteQuotes, randomQuotes, unsupported
        
        init(rawValue: Int) {
            switch rawValue {
            case 0: self = .topThreeQuotes
            case 1: self = .userFavoriteQuotes
            case 2: self = .randomQuotes
            default: self = .unsupported
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.randomQuotes.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .appDarkBrown
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = TableSection(rawValue: section)
        
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            switch tableSection {
            case .topThreeQuotes: return "Top 3 favorite quotes"
            case .userFavoriteQuotes: return "Your quotes"
            case .randomQuotes: return "Random quote"
            default: return "Unknown section"
            }
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableSection = TableSection(rawValue: section)
        
        switch tableSection {
        case .topThreeQuotes: return topThreeQuotes.count
        case .userFavoriteQuotes: return userFavoriteQuotes.count
        case .randomQuotes: return randomQuote.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotesCell", for: indexPath)
        guard let quoteCell = cell as? QuotesTableViewCell else { return cell }
        let tableSection = TableSection(rawValue: indexPath.section)
        let quoteTextForCell: String
        let quoteFavoriteCountForCell: Int?
        let quoteForCell: Quote
        
        switch tableSection {
        case .topThreeQuotes:
            quoteTextForCell = topThreeQuotes[indexPath.row].quote
            quoteFavoriteCountForCell = topThreeQuotesCount[indexPath.row]
            quoteForCell = topThreeQuotes[indexPath.row]
            quoteCell.isFavoriteQuote = QuoteManager.isQuoteFavorite(quoteForCell)
        case .userFavoriteQuotes:
            quoteTextForCell = userFavoriteQuotes[indexPath.row].quote
            quoteFavoriteCountForCell = nil
            quoteForCell = userFavoriteQuotes[indexPath.row]
            quoteCell.isFavoriteQuote = QuoteManager.isQuoteFavorite(quoteForCell)
        case .randomQuotes:
            quoteTextForCell = randomQuote[indexPath.row].quote
            quoteFavoriteCountForCell = nil
            quoteForCell = randomQuote[indexPath.row]
            quoteCell.isFavoriteQuote = QuoteManager.isQuoteFavorite(quoteForCell)
        default:
            quoteTextForCell = ""
            quoteFavoriteCountForCell = nil

        }
        quoteCell.configureCell(quote: quoteTextForCell, favoriteCount: quoteFavoriteCountForCell)
        
        return quoteCell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let tableSection = TableSection(rawValue: indexPath.section)

        switch tableSection {
        case .topThreeQuotes: return false
        case .userFavoriteQuotes: return true
        case .randomQuotes: return false
        default: return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let quoteToDelete = userFavoriteQuotes[indexPath.row]
            deleteQuoteFromFavorties(quoteToDelete)
            userFavoriteQuotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            reloadData()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableSection = TableSection(rawValue: indexPath.section)
        var selectedQuote: Quote
        
        switch tableSection {
        case .topThreeQuotes:
            selectedQuote = topThreeQuotes[indexPath.row]
            saveFavoriteQuotes(selectedQuote)
        case .userFavoriteQuotes:
            selectedQuote = userFavoriteQuotes[indexPath.row]
            saveFavoriteQuotes(selectedQuote)
        case .randomQuotes:
            selectedQuote = randomQuote[indexPath.row]
            saveFavoriteQuotes(selectedQuote)
        default:
            print("Nothing selected")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let tableSection = TableSection(rawValue: indexPath.section)
        var deselectedQuote: Quote
        
        switch tableSection {
        case .topThreeQuotes:
            deselectedQuote = topThreeQuotes[indexPath.row]
            deleteQuoteFromFavorties(deselectedQuote)
        case .userFavoriteQuotes:
            deselectedQuote = userFavoriteQuotes[indexPath.row]
            deleteQuoteFromFavorties(deselectedQuote)
        case .randomQuotes:
            deselectedQuote = randomQuote[indexPath.row]
            deleteQuoteFromFavorties(deselectedQuote)
        default:
            print("Nothing deselected")
        }
    }
}

//MARK: - Favorite quote functionality -

extension QuotesViewController {
    
    private func saveFavoriteQuotes(_ quote: Quote) {
        QuoteManager.saveFavoriteQuote(quote)
        reloadData()
        tableView.reloadData()
    }
    
    private func deleteQuoteFromFavorties(_ quote: Quote) {
        if let loggedInAccount = UserDefaultsManager.loggedInAccount {
            QuoteManager.deleteFavoriteQuote(quote, username: loggedInAccount.username)
        }
    }
    
    private func reloadData() {
        topThreeQuotes = QuoteManager.topThreeQuotes.threeQuotes
        topThreeQuotesCount = QuoteManager.topThreeQuotes.threeQuotesCount
        userFavoriteQuotes = QuoteManager.userFavoriteQuotes
        randomQuote = []
        loadRandomQuote()
    }
}
