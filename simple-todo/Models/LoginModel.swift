//
//  LoginModel.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import Foundation

class LoginModel {
    var email = ""
    var password = ""
    
    convenience init (email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
