//
//  AuthenticationViewController.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-24.
//

import UIKit

class AuthenticationViewController: ParentViewController, UITextFieldDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var AuthenticationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var authenticationTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmationTextField.delegate = self
        changeSubmitButtonStatus(state: false, alpha: 0.5)
        logoImage.image = UIImage(named: "breakingBadFanLogo")
        submitButton.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        advanceToHomeScreen()
    }

    @IBAction func authenticationTypeDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            passwordConfirmationTextField.isHidden = true
            clearTextFields()
        default:
            passwordConfirmationTextField.isHidden = false
            clearTextFields()
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        switch authenticationTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            submitLogin()
        default:
            submitRegistration()
        }
    }
}

//MARK: - Account authentication -

extension AuthenticationViewController {
    
    private func submitRegistration() {
        do {
            try AccountManager.registerAccount(username: usernameTextField.text, password: passwordTextField.text, loginStatus: true, confirmedPassword: passwordConfirmationTextField.text)
            proceedToHomeScreenView()
        } catch {
            if let error = error as? AccountManager.AccountManagerError {
                showAlert(title: error.errorDescription)
            }
        }
    }
    
    private func submitLogin() {
        do {
            try AccountManager.loginUser(username: usernameTextField.text, password: passwordTextField.text, loginStatus: true)
            proceedToHomeScreenView()
        } catch {
            if let error = error as? AccountManager.AccountManagerError {
                showAlert(title: error.errorDescription)
            }
        }
    }
}

//MARK: - Text field configuration -

extension AuthenticationViewController {
    
    private func clearTextFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        passwordConfirmationTextField.text = ""
    }
}

//MARK: - Submit button configuration -

extension AuthenticationViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch authenticationTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            if usernameTextField.text == "" || passwordTextField.text == "" {
                changeSubmitButtonStatus(state: false, alpha: 0.5)
            } else {
                changeSubmitButtonStatus(state: true, alpha: 1.0)
            }
        default:
            if usernameTextField.text == "" || passwordTextField.text == "" || passwordConfirmationTextField.text == "" {
                changeSubmitButtonStatus(state: false, alpha: 0.5)
            } else {
                changeSubmitButtonStatus(state: true, alpha: 1.0)
            }
        }
        return true
    }
    
    private func changeSubmitButtonStatus(state: Bool, alpha: Double) {
        submitButton.isEnabled = state
        submitButton.alpha = CGFloat(alpha)
    }
}

//MARK: - Navigation helpers -

extension AuthenticationViewController {

    private func isUserLoggedIn() -> Bool {
        UserDefaultsManager.loggedInAccount != nil
    }
    
    private func advanceToHomeScreen() {
        if isUserLoggedIn() {
            proceedToHomeScreenView()
        }
    }
}
