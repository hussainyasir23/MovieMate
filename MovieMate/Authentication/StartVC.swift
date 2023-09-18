//
//  StartVC.swift
//  MovieMate
//
//  Created by Yasir on 16/09/23.
//

import UIKit

class StartVC: UIViewController {
    
    // UI Components
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageConstants.logo
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var logoCenterYConstraint: NSLayoutConstraint?
    private var logoTopConstraint: NSLayoutConstraint?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Mate"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.alpha = 0
        return label
    }()
    
    private lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Movie Companion."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.alpha = 0
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.styleAsLoginButton()
        button.addTarget(self, action: #selector(didSelectSignUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.alpha = 0
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.styleAsLoginButton()
        button.addTarget(self, action: #selector(didSelectLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.alpha = 0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        
        view.backgroundColor = ColorConstants.backgroundPrimary
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(taglineLabel)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
    }
    
    private func setupLayouts() {
        
        logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoCenterYConstraint = logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        logoCenterYConstraint?.isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16).isActive = true
        
        taglineLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        taglineLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        taglineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        
        signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -24).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLogoToTop()
    }
    
    private func animateLogoToTop() {
        
        logoCenterYConstraint?.isActive = false
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64)
        logoTopConstraint?.isActive = true
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.showTitleLabel()
        })
    }
    
    private func showTitleLabel() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.titleLabel.alpha = 1
            self.titleLabel.isHidden = false
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.showTagline()
        })
    }
    
    private func showTagline() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.taglineLabel.alpha = 1
            self.taglineLabel.isHidden = false
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.showButtons()
        })
    }
    
    private func showButtons() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.signUpButton.alpha = 1
            self.signUpButton.isHidden = false
            self.loginButton.alpha = 1
            self.loginButton.isHidden = false
        }, completion: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateColorsForCurrentTheme()
        }
    }
    
    private func updateColorsForCurrentTheme() {
        signUpButton.styleAsLoginButton()
        loginButton.styleAsLoginButton()
    }
    
    @objc private func didSelectSignUp() {
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    
    @objc private func didSelectLogin() {
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
}
