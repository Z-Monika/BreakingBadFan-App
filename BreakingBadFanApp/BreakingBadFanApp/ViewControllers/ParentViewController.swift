//
//  ParentViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import UIKit

class ParentViewController: UIViewController {
    
    typealias VoidCompletion = () -> Void
    private let failureAlertTitle = "Oops!"
    
//MARK: - Storyboards -
    
    private lazy var HomeScreenStoryboard: UIStoryboard = {
        UIStoryboard(name: "HomeScreen", bundle: nil)
    }()
    
    private lazy var MainStoryboard: UIStoryboard = {
        UIStoryboard(name: "Main", bundle: nil)
    }()
    
//MARK: - UIViewControllers -
    
    private var HomeScreenViewController: UIViewController {
        MainStoryboard.instantiateViewController(identifier: "HomeScreenViewController")
    }
    
    private var EpisodesViewController: UIViewController {
        MainStoryboard.instantiateViewController(identifier: "EpisodesPreviewViewController")
    }
    
    private var FilterEpisodesPopUpViewControlles: UIViewController {
        FilterEpisodesPopUpViewController()
    }
    
    private var CharactersPreviewViewController: UIViewController {
        MainStoryboard.instantiateViewController(withIdentifier: "CharactersPreviewViewController")
    }
    
    private var CharactersDetailsViewController: UIViewController {
        MainStoryboard.instantiateViewController(withIdentifier: "CharacterDetailsViewController")
    }
    
    private var FilterCharactersPopUpViewControlles: UIViewController {
        FilterCharactersPopUpViewController()
    }
    
    private var QuotesViewController: UIViewController {
        MainStoryboard.instantiateViewController(withIdentifier: "QuotesViewController")
    }
    
//MARK: - Alert functionality -
    
    func showAlert(title: String, animated: Bool = true) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Navigation -

extension ParentViewController {
    
    func proceedToHomeScreenView() {
        modalPresentationStyle = .fullScreen
        present(HomeScreenViewController, animated: true)
    }
    
    func proceedToEpisodesScreenView() {
        modalTransitionStyle = .coverVertical
        present(EpisodesViewController, animated: true)
    }
    
    func proceedToFilterEpisodesPopUpView() {
        modalTransitionStyle = .coverVertical
        present(FilterEpisodesPopUpViewControlles, animated: true)
    }
    
    func proceedToCharactersPreviewViewController() {
        modalTransitionStyle = .coverVertical
        present(CharactersPreviewViewController, animated: true)
    }
    
    func proceedToCharacterDetailsViewController() {
        modalTransitionStyle = .coverVertical
        present(CharactersDetailsViewController, animated: true)
    }
    
    func proceedToFilterCharactersPopUpView() {
        modalTransitionStyle = .coverVertical
        present(FilterCharactersPopUpViewControlles, animated: true)
    }
    
    func proceedToQuotesViewController() {
        modalTransitionStyle = .coverVertical
        present(QuotesViewController, animated: true)
    }
}
