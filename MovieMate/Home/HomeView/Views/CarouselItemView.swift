//
//  CarouselItemView.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

class CarouselItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = overlayView.bounds
    }
    
    private func setupViews() {
        addSubview(backDropView)
        addSubview(overlayView)
        overlayView.addSubview(labelStack)
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(ratingLabel)
    }
    
    private func setupLayouts() {
        
        backDropView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backDropView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backDropView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backDropView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        overlayView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        overlayView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        
        labelStack.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 10).isActive = true
        labelStack.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -5).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    }
    
    private lazy var backDropView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = ColorConstants.backgroundPrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, ColorConstants.contentPrimary.withAlphaComponent(0.75).cgColor]
        overlayView.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Label"
        label.textAlignment = .left
        label.textColor = ColorConstants.backgroundPrimary
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.5/10"
        label.textAlignment = .right
        label.textColor = ColorConstants.backgroundSecondary
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func updateTitle(_ title: String, rating: Double) {
        
        let ratingText: String = "\(round(rating * 10) / 10)/10"
        
        titleLabel.text = title
        ratingLabel.text = ratingText
        
        let attributes = [NSAttributedString.Key.font: ratingLabel.font!]
        let requiredSize = ratingText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                                height: ratingLabel.bounds.height),
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: attributes,
                                                   context: nil).size
        ratingLabel.widthAnchor.constraint(equalToConstant: ceil(requiredSize.width)).isActive = true
    }
    
    
    func updateBackDrop(_ backDrop: UIImage) {
        self.backDropView.image = backDrop
    }
}
