//
//  UITextField+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/12/21.
//

import UIKit

extension UITextField {
    public convenience init(placeHolder: String) {
        self.init()
        self.borderStyle = .none
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 216/255)
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 17)
        self.autocorrectionType = .no

        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(
            attributedString: NSAttributedString(
                string: placeHolder,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7)]
            )
        )
        
        self.attributedPlaceholder = placeholder
        self.setAnchor(width: 0, height: 40)
        self.setLeftPaddingPoints(20)
    }
    
    func setLeftPaddingPoints(_ spacing: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
