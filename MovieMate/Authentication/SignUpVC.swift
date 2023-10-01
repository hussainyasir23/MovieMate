//
//  SignUpVC.swift
//  MovieMate
//
//  Created by Yasir on 17/09/23.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController, UITextFieldDelegate {
    
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
        label.textColor = ColorConstants.error
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
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.styleAsLoginButton()
        button.addTarget(self, action: #selector(didSelectSignUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ColorConstants.error
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
        view.addSubview(signUpButton)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupLayouts() {
        
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: emailValidationLabel.topAnchor, constant: -8).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        emailValidationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        emailValidationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        emailValidationLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -24).isActive = true
        emailValidationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordValidationLabel.topAnchor, constant: -8).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        passwordValidationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        passwordValidationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        passwordValidationLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -48).isActive = true
        passwordValidationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -128).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc private func didSelectSignUp() {
        let email = emailTextField.text ?? ""
        if let errorMessage = Validator.validateEmail(email) {
            emailValidationLabel.text = errorMessage
            return
        } else {
            emailValidationLabel.text = ""
        }
        
        let password = passwordTextField.text ?? ""
        if let errorMessage = Validator.validatePassword(password) {
            passwordValidationLabel.text = errorMessage
            return
        } else {
            passwordValidationLabel.text = ""
        }
        
        signUpButton.isEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                // Handle error (show an error message or alert)
                print("Error signing up: \(error?.localizedDescription ?? "Unknown error")")
                self.signUpButton.isEnabled = true
                return
            }
            
            
            
            // User was successfully created. Send verification email
            user.sendEmailVerification { error in
                if let error = error {
                    // Handle error (show an error message or alert)
                    print("Error sending verification email: \(error.localizedDescription)")
                    return
                }
                
                // Email sent successfully. You can navigate to a different screen or show a success message
                // For instance:
                let alertController = UIAlertController(title: "Success", message: "A verification email has been sent to \(email). Please verify your email before logging in.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
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
        signUpButton.styleAsLoginButton()
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            didSelectSignUp()
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
