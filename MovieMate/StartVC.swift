//
//  StartVC.swift
//  MovieMate
//
//  Created by Yasir on 16/09/23.
//

import UIKit

class StartVC: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoImage")
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
        let button = UIButton(type: .custom)
        button.setTitle("Get Started", for: .normal)
        button.styleAsButton()
        return button
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Log In", for: .normal)
        button.styleAsButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews() {
        
        self.view.backgroundColor = UIColor(named: "PBackgroundColor")
        self.view.addSubview(logoImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(taglineLabel)
        self.view.addSubview(signUpButton)
        self.view.addSubview(logInButton)
        
        setupInitialConstraints()
    }
    
    private func setupInitialConstraints() {
        
        logoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoCenterYConstraint = logoImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        logoCenterYConstraint?.isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 16).isActive = true
        
        taglineLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        taglineLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        taglineLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        
        signUpButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: self.logInButton.topAnchor, constant: -24).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        logInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        logInButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLogoToTop()
    }
    
    private func animateLogoToTop() {
        
        logoCenterYConstraint?.isActive = false
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 64)
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
            self.logInButton.alpha = 1
            self.logInButton.isHidden = false
        }, completion: nil)
    }
}

fileprivate extension UIButton {
    
    func styleAsButton() {
        setTitleColor(UIColor(named: "PTextColor"), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = UIColor(named: "PBackgroundColor")
        contentMode = .center
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "PTextColor")?.cgColor
        layer.shadowColor = UIColor(named: "PTextColor")?.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        alpha = 0
    }
}
