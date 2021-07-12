//
//  UIButtton+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/12/21.
//

import UIKit

extension UIButton {
    public convenience init(title: String, borderColor: UIColor) {
        self.init()
        let attributedString = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: title,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    .foregroundColor: UIColor(white: 1, alpha: 0.7)
                ]
            )
        )
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        self.setAnchor(width: 0, height: 50)
    }
}
