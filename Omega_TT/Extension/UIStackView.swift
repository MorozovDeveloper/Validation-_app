//
//  UIStackView.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit

extension UIStackView {
    
    // convenience - вспомогательный инициализатор
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
