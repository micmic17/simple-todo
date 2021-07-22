//
//  FormValidationHelper.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/22/21.
//

import Foundation


func isLoginFormValid(email: String?, password: String?) -> Bool {
    guard let email = email, password != nil else { return false }
    
    if !email.isValidEmail { return false }
    
    return true
}

func isLoginFormNotNil(email: String?, password: String?) -> Bool {
    guard let email = email, let password = password else { return false }
    
    return email.count > 0 && password.count > 0
}

func isSignUpFormValid(
    email: String?,
    password: String?,
    firstName: String?,
    middleName: String?,
    lastName: String?,
    suffix: String?,
    age: String?,
    gender: String?,
    mobileNumber: String?,
    address: String?
) -> Bool {
    guard let email = email, password != nil, firstName != nil,
          lastName != nil, let age = age, let gender = gender,
          let mobileNumber = mobileNumber, address != nil else { return false }
    
    if !email.isValidEmail { return false }
    
    if !age.isNumber { return false }
    
    if !mobileNumber.isNumber && !mobileNumber.isValidMobileNumber { return false }
    
    if gender == "Male" || gender == "Female" { return false }
    
    return true
}

func isSignUpFormNotNil(
     email: String?,
     password: String?,
     firstName: String?,
     middleName: String?,
     lastName: String?,
     suffix: String?,
     age: String?,
     gender: String?,
     mobileNumber: String?,
     address: String?
 ) -> Bool {
     guard let email = email, let password = password, let firstName = firstName,
           let lastName = lastName, let age = age, let gender = gender, let mobileNumber = mobileNumber,
           let address = address else { return false }

     return email.count > 0 && password.count > 0 && firstName.count > 0 && lastName.count > 0 && age.count > 0
         && gender.count > 0 && mobileNumber.count > 0 && address.count > 0
 }
