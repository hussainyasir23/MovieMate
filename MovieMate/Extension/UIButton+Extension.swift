//
//  UIButton+Extension.swift
//  MovieMate
//
//  Created by Yasir on 18/09/23.
//

import UIKit

extension UIButton {
    
    func styleAsLoginButton() {
        setTitleColor(ColorConstants.contentPrimary, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = ColorConstants.backgroundPrimary
        contentMode = .center
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = ColorConstants.contentPrimary.cgColor
        layer.shadowColor = ColorConstants.contentPrimary.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
