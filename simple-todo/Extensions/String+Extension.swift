//
//  String+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/16/21.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailInput = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailInput.evaluate(with: self)
    }
}
