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
    
    private func setupViews() {
        addSubview(backDropView)
        addSubview(labelStack)
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(ratingLabel)
    }
    
    private func setupLayouts() {
        
        backDropView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backDropView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backDropView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backDropView.heightAnchor.constraint(equalToConstant: (self.bounds.width / 1280) * 720).isActive = true
        
        labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        labelStack.topAnchor.constraint(equalTo: backDropView.bottomAnchor).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private lazy var backDropView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = ColorConstants.backgroundPrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Label"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = ColorConstants.contentPrimary
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.5/10"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = ColorConstants.contentPrimary
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .bottom
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
