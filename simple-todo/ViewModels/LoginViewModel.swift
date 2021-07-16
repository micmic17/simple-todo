//
//  LoginViewModel.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import Foundation
import ReactiveSwift

class LoginViewModel: LoginViewModelInputs, LoginViewModelOutputs, LoginViewModelType {
    let service: LoginAPIService
    var rootVC = UIViewController()
    var alertMessage: Signal<String, Never>
    let loginButtonEnabled: Signal<Bool, Never>
    
    init(usingService: LoginAPIService) {
        let formData = Signal.combineLatest(self.emailChangedProperty.signal, self.passwordChangedProperty.signal)
        
        let successfulLoginMessage = formData
            .sample(on: self.loginButtonPressedProperty.signal)
            .filter(isValidForm(email:password:))
            .map { _ in "Login Successfully" }
        
        let submittedInvalidFormData = formData
            .sample(on: self.loginButtonPressedProperty.signal)
            .filter {
                !isValidForm(email: $0, password: $1)
            }
        
        let unsuccessfulyLoginMessage = submittedInvalidFormData
            .take(first: 2)
            .map { _ in "Login Uncessfully" }
        
        self.alertMessage = Signal.merge(successfulLoginMessage, unsuccessfulyLoginMessage)
        self.loginButtonEnabled = Signal.merge(
            self.viewDidLoadProperty.signal.map { _ in false },
            formData.map(isNotNil(email:password:))
        )
        
        self.service = usingService
    }
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
    let emailChangedProperty = MutableProperty<String?>(nil)
    func emailChanged(email: String?) {
        self.emailChangedProperty.value = email
    }
    
    let passwordChangedProperty = MutableProperty<String?>(nil)
    func passwordChanged(password: String?) {
        self.passwordChangedProperty.value = password
    }
    
    let loginButtonPressedProperty = MutableProperty(())
    func loginButtonPressed() {
        self.loginButtonPressedProperty.value = ()
    }
    
    let viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        self.viewDidLoadProperty.value = ()
        self.observeAlert()
    }
    
    func observeAlert() {
        alertMessage.signal.observeValues { message in
            if message == "Login Successfully" { self.loginUser() }
        }
    }
    
    func loginUser() {
        guard let email = emailChangedProperty.value,
              let password = passwordChangedProperty.value else { return }
        
        service.loginUser(email: email, password: password) { response in
            switch response {
            case .success(let auth):
                let homeVC = HomeViewController()
                
                homeVC.modalPresentationStyle = .overFullScreen
                self.rootVC.present(homeVC, animated: true, completion: nil)
                
                break
            case .failure(let error):
                print(error)

                break
            }
        }
    }
}

protocol LoginViewModelInputs {
    func emailChanged(email: String?)
    func passwordChanged(password: String?)
    func loginButtonPressed()
    func viewDidLoad()
}

protocol LoginViewModelOutputs {
    var alertMessage: Signal<String, Never> { get }
    var loginButtonEnabled: Signal<Bool, Never> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}
