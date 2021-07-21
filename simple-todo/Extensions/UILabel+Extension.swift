//
//  UILabel+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/14/21.
//

import UIKit

extension UILabel {
    public convenience init(title: String) {
        self.init()
        self.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.font = UIFont.italicSystemFont(ofSize: 14)
        self.text = title
        self.textAlignment = .right
        self.textColor = .red
        self.isHidden = true
    }
}
