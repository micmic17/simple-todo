//
//  LoginFormValidation.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/16/21.
//

import Foundation

func isValidForm(email: String?, password: String?) -> Bool {
    guard let email = email, password != nil else { return false }
    
    if !email.isValidEmail { return false }
    
    return true
}

func isNotNil(email: String?, password: String?) -> Bool {
    guard let email = email, let password = password else { return false }
    
    return email.count > 0 && password.count > 0
}
