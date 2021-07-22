//
//  SignUpViewModel.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/22/21.
//

import Foundation
import ReactiveSwift
import Firebase

protocol SignUpViewModelInputs {
    func emailChanged(email: String?)
    func passwordChanged(password: String?)
    func firstNameChanged(firstName: String?)
    func middleNameChanged(middleName: String?)
    func lastNameChanged(lastName: String?)
    func suffixChanged(suffix: String?)
    func ageChanged(age: String?)
    func genderChanged(gender: String?)
    func mobileNumberChanged(mobileNumber: String?)
    func addressChanged(address: String?)
    func submitButtonPressed()
    func viewDidLoad()
}

protocol SignUpViewModelOutputs {
    var alertMessage: Signal<String, Never> { get }
    var submitButtonEnabled: Signal<Bool, Never> { get }
    var userID: MutableProperty<String> { get }
}

protocol SignUpViewModelType {
    var inputs: SignUpViewModelInputs { get }
    var outputs: SignUpViewModelOutputs { get }
}

class SignUpViewModel: SignUpViewModelInputs, SignUpViewModelOutputs, SignUpViewModelType {
    let service: SignUpAPIService
    let alertMessage: Signal<String, Never>
    let submitButtonEnabled: Signal<Bool, Never>
    let userID: MutableProperty<String> = MutableProperty("")
    
    init(usingService: SignUpAPIService) {
        let formData = Signal.combineLatest(
            self.emailChangedProperty.signal,
            self.passwordChangedProperty.signal,
            self.firstNameChangedProperty.signal,
            self.middleNameChangedProperty.signal,
            self.lastNameChangedProperty.signal,
            self.suffixChangedProperty.signal,
            self.ageChangedProperty.signal,
            self.genderChangedProperty.signal,
            self.mobileNumberChangedProperty.signal,
            self.addressChangedProperty.signal
        )
        
        let success = formData
            .sample(on: self.submitButtonPressedProperty.signal)
            .filter(isSignUpFormValid(email:password:firstName:middleName:lastName:suffix:age:gender:mobileNumber:address:))
            .map { _ in "Successfully Registered" }
        
        let fail = formData
            .sample(on: self.submitButtonPressedProperty.signal)
            .filter { !isSignUpFormValid(email: $0,
                              password: $1,
                              firstName: $2,
                              middleName: $3,
                              lastName: $4,
                              suffix: $5,
                              age: $6,
                              gender: $7,
                              mobileNumber: $8,
                              address: $9)
            }.map { _ in "Failed in registering user" }
        
        self.alertMessage = Signal.merge(success, fail)
        self.submitButtonEnabled = Signal.merge(
            self.viewDidLoadProperty.signal.map { _ in false },
            formData.map { isSignUpFormNotNil(email: $0,
                                     password: $1,
                                     firstName: $2,
                                     middleName: $3,
                                     lastName: $4,
                                     suffix: $5,
                                     age: $6,
                                     gender: $7,
                                     mobileNumber: $8,
                                     address: $9)
            }
        )
        
        self.service = usingService
    }
    
    var inputs: SignUpViewModelInputs { return self }
    var outputs: SignUpViewModelOutputs { return self }
    
    let emailChangedProperty = MutableProperty<String?>(nil)
    func emailChanged(email: String?) {
        self.emailChangedProperty.value = email
    }
    
    let passwordChangedProperty = MutableProperty<String?>(nil)
    func passwordChanged(password: String?) {
        self.passwordChangedProperty.value = password
    }
    
    let firstNameChangedProperty = MutableProperty<String?>(nil)
    func firstNameChanged(firstName: String?) {
        self.firstNameChangedProperty.value = firstName
    }
    
    let middleNameChangedProperty = MutableProperty<String?>(nil)
    func middleNameChanged(middleName: String?) {
        self.middleNameChangedProperty.value = middleName
    }
    
    let lastNameChangedProperty = MutableProperty<String?>(nil)
    func lastNameChanged(lastName: String?) {
        self.lastNameChangedProperty.value = lastName
    }
    
    let suffixChangedProperty = MutableProperty<String?>(nil)
    func suffixChanged(suffix: String?) {
        self.suffixChangedProperty.value = suffix
    }
    
    let ageChangedProperty = MutableProperty<String?>(nil)
    func ageChanged(age: String?) {
        self.ageChangedProperty.value = age
    }
    
    let genderChangedProperty = MutableProperty<String?>(nil)
    func genderChanged(gender: String?) {
        self.genderChangedProperty.value = gender
    }
    
    let mobileNumberChangedProperty = MutableProperty<String?>(nil)
    func mobileNumberChanged(mobileNumber: String?) {
        self.mobileNumberChangedProperty.value = mobileNumber
    }
    
    let addressChangedProperty = MutableProperty<String?>(nil)
    func addressChanged(address: String?) {
        self.addressChangedProperty.value = address
    }
    
    let submitButtonPressedProperty = MutableProperty(())
    func submitButtonPressed() {
        print("submit")
        self.submitButtonPressedProperty.value = ()
    }
    
    let viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        self.viewDidLoadProperty.value = ()
        observeAlert()
    }
    
    func observeAlert() {
        alertMessage.signal
            .observeValues { message in
                if message == "Successfully Registered" {
                    self.signUpUser()
                }
            }
    }
    
    func signUpUser() {
        guard let email = emailChangedProperty.value,
              let password = passwordChangedProperty.value,
              let firstName = firstNameChangedProperty.value,
              let middleName = middleNameChangedProperty.value,
              let lastName = lastNameChangedProperty.value,
              let suffix = suffixChangedProperty.value,
              let age = ageChangedProperty.value,
              let gender = genderChangedProperty.value,
              let mobileNumber = mobileNumberChangedProperty.value,
              let address = genderChangedProperty.value else { return }
        
        service.signUpUser(email: email,
                           password: password,
                           firstName: firstName,
                           middleName: middleName,
                           lastName: lastName,
                           suffix: suffix,
                           age: age,
                           gender: gender,
                           mobileNumber: mobileNumber,
                           address: address
        ) { response in
            switch response {
            case .success(let uid):
                self.userID.value = uid
            case .failure(let error):
                print(error)
            }
        }
    }
}
