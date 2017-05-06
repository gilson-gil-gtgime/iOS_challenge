//
//  AuthenticationViewController.swift
//  MimoiOSCodingChallenge
//
//  Created by Gilson Gil on 06/05/17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit
import PureLayout

final class AuthenticationViewController: UIViewController {
    struct ViewConstants {
        fileprivate static let topMargin: CGFloat = 80
        fileprivate static let sideMargin: CGFloat = 30
        fileprivate static let interItemMargin: CGFloat = 30
        fileprivate static let textFieldHeight: CGFloat = 50
        fileprivate static let buttonHeight: CGFloat = 50
    }
    
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField.newAutoLayout()
        textField.placeholder = String.Authentication.Placeholder.email
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.borderStyle = .line
        return textField
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField.newAutoLayout()
        textField.placeholder = String.Authentication.Placeholder.password
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.borderStyle = .line
        return textField
    }()
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.Authentication.ButtonTitle.login, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.backgroundColor = .black
        return button
    }()
    
    fileprivate let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.Authentication.ButtonTitle.signup, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.backgroundColor = .black
        return button
    }()
    
    fileprivate var authenticationViewModel = AuthenticationViewModel()
    
    var delegate: AuthenticationViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        emailTextField.autoPinEdge(.top, to: .top, of: view, withOffset: ViewConstants.topMargin)
        emailTextField.autoPinEdge(.left, to: .left, of: view, withOffset: ViewConstants.sideMargin)
        emailTextField.autoPinEdge(.right, to: .right, of: view, withOffset: -ViewConstants.sideMargin)
        emailTextField.autoSetDimension(.height, toSize: ViewConstants.textFieldHeight)
        
        passwordTextField.autoPinEdge(.top, to: .bottom, of: emailTextField, withOffset: ViewConstants.interItemMargin)
        passwordTextField.autoPinEdge(.left, to: .left, of: view, withOffset: ViewConstants.sideMargin)
        passwordTextField.autoPinEdge(.right, to: .right, of: view, withOffset: -ViewConstants.sideMargin)
        passwordTextField.autoSetDimension(.height, toSize: ViewConstants.textFieldHeight)
        
        loginButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: ViewConstants.interItemMargin)
        loginButton.autoPinEdge(.left, to: .left, of: view, withOffset: ViewConstants.sideMargin)
        loginButton.autoPinEdge(.right, to: .right, of: view, withOffset: -ViewConstants.sideMargin)
        loginButton.autoSetDimension(.height, toSize: ViewConstants.buttonHeight)
        
        signupButton.autoPinEdge(.top, to: .bottom, of: loginButton, withOffset: ViewConstants.interItemMargin)
        signupButton.autoPinEdge(.left, to: .left, of: view, withOffset: ViewConstants.sideMargin)
        signupButton.autoPinEdge(.right, to: .right, of: view, withOffset: -ViewConstants.sideMargin)
        signupButton.autoSetDimension(.height, toSize: ViewConstants.buttonHeight)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - Actions
extension AuthenticationViewController {
    func loginTapped() {
        authenticationViewModel.login(email: emailTextField.text, password: passwordTextField.text) { [weak self] callback in
            do {
                try callback()
                self?.delegate?.didAuthenticate(in: self)
            } catch let error as LoginError {
                switch error {
                case .accountNotFound:
                    AlertHelper.alert(title: String.warning, message: error.localizedDescription, in: self)
                }
            } catch {
                AlertHelper.alert(title: String.warning, message: error.localizedDescription, in: self)
            }
        }
    }
    
    func signupTapped() {
        authenticationViewModel.signup(email: emailTextField.text, password: passwordTextField.text) { [weak self] callback in
            do {
                try callback()
                self?.delegate?.didAuthenticate(in: self)
            } catch let error as SignUpError {
                switch error {
                case .accountFound:
                    AlertHelper.alert(title: String.warning, message: error.localizedDescription, in: self)
                }
            } catch {
                AlertHelper.alert(title: String.warning, message: error.localizedDescription, in: self)
            }
        }
    }
}

// MARK: - UITextField Delegate
extension AuthenticationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        let noSpacingText = newText.noSpacingString()
        textField.text = noSpacingText
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
