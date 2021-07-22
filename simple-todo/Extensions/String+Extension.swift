//
//  String+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/16/21.
//

import Foundation

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var isValidMobileNumber: Bool {
        let phoneRegex = #"^(09|\+639)\d{9}$"#
        let phoneInput = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneInput.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailInput = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailInput.evaluate(with: self)
    }
}
