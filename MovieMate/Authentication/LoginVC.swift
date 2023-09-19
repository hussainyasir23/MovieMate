//
//  LoginVC.swift
//  MovieMate
//
//  Created by Yasir on 17/09/23.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Email"
        textField.textColor = ColorConstants.contentPrimary
        textField.backgroundColor = ColorConstants.backgroundSecondary
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let emailIconView = UIImageView(frame: CGRect(x: 7.5, y: 2.5, width: 15, height: 15))
        emailIconView.image = ImageConstants.email
        emailIconView.tintColor = ColorConstants.contentPrimary
        emailIconView.contentMode = .scaleAspectFit
        
        let emailIconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        emailIconContainerView.addSubview(emailIconView)
        textField.leftView = emailIconContainerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var emailValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ColorConstants.contentSecondary
        label.font = UIFont.systemFont(ofSize: 13 ,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Password"
        textField.textColor = ColorConstants.contentPrimary
        textField.backgroundColor = ColorConstants.backgroundSecondary
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordIconView = UIImageView(frame: CGRect(x: 7.5, y: 2.5, width: 15, height: 15))
        passwordIconView.image = ImageConstants.password
        passwordIconView.contentMode = .scaleAspectFit
        passwordIconView.tintColor = ColorConstants.contentPrimary
        
        let passwordIconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        passwordIconContainerView.addSubview(passwordIconView)
        textField.leftView = passwordIconContainerView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.styleAsLoginButton()
        button.addTarget(self, action: #selector(didSelectLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ColorConstants.contentSecondary
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = ColorConstants.backgroundPrimary
        view.addSubview(emailTextField)
        view.addSubview(emailValidationLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidationLabel)
        view.addSubview(loginButton)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupLayouts() {
        
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        emailValidationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        emailValidationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        emailValidationLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailValidationLabel.bottomAnchor, constant: 24).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        passwordValidationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        passwordValidationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordValidationLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordValidationLabel.bottomAnchor, constant: 40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc private func didSelectLogin() {
        
    }
    
    @objc private func didTapOutside() {
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateColorsForCurrentTheme()
        }
    }
    
    private func updateColorsForCurrentTheme() {
        loginButton.styleAsLoginButton()
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            didSelectLogin()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField,
           let email = emailTextField.text {
            if let errorMessage = Validator.validateEmail(email) {
                emailValidationLabel.text = errorMessage
            } else {
                emailValidationLabel.text = ""
            }
        } else if textField == passwordTextField,
                  let password = passwordTextField.text {
            if let errorMessage = Validator.validatePassword(password) {
                passwordValidationLabel.text = errorMessage
            } else {
                passwordValidationLabel.text = ""
            }
        }
    }
}
