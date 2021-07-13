//
//  UIStackView+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/12/21.
//

import UIKit

extension UIView {
    func createStackView(
        views: [UIView],
        _ axis: NSLayoutConstraint.Axis,
        _ distribution: UIStackView.Distribution,
        _ spacing: CGFloat
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing
        
        return stackView
    }
}
