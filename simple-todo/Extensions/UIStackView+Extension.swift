//
//  UIStackView+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/12/21.
//

import UIKit

extension UIView {
    func createStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }
}
