//
//  HomeScreenViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import UIKit

class HomeScreenViewController: ParentViewController {

    private let apiManager = APIManager()
    private let characterDetailsViewController = CharacterDetailsViewController()
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var episodesButton: UIButton!
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var quotesButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        characterDetailsViewController.quoteSaveDelegate = self
        logoImage.image = UIImage(named: "breakingBadFanLogo")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUsernameLabel()
        configureView()
    }
    
    @IBAction func episodesButtonPressed(_ sender: Any) {
        proceedToEpisodesScreenView()
    }
    
    @IBAction func charactersButtonPressed(_ sender: Any) {
        proceedToCharactersPreviewViewController()
    }
    
    @IBAction func quotesButtonPressed(_ sender: Any) {
        proceedToQuotesViewController()
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        AccountManager.logoutUser()
        dismiss(animated: true)
    }
    
    //MARK: - Configure UI -
    
    private func configureView() {
        setUsernameLabel()
        episodesButton.layer.cornerRadius = 8
        charactersButton.layer.cornerRadius = 8
        quotesButton.layer.cornerRadius = 8
        
//        enableQuotesButton()
    }
    
//MARK: - Set label -
    
    private func setUsernameLabel() {
        if let loggedInAccount = UserDefaultsManager.loggedInAccount {
            usernameLabel.text = ("\(loggedInAccount.username)")
        }
    }

//MARK: - Enable quotes button -
    
    private func enableQuotesButton() {
        let userQuotes = QuoteManager.userFavoriteQuotes
        if userQuotes.count == 0 {
            quotesButton.isHidden = true
        } else {
            quotesButton.isHidden = false
        }
    }
}

//MARK: - Quote save delegate implementation -

extension HomeScreenViewController: QuoteSaveDelegate {
    
    func didSaveFavoriteQuote() {
        enableQuotesButton()
        self.view.layoutIfNeeded()
    } 
}
