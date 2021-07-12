//
//  LoginViewModel.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class LoginViewModel {
    let model = LoginModel()
    let disposeBag = DisposeBag()
    let auth = Auth.auth()

    // Initialize view models
    let emailvm = EmailViewModel()
    let passwordvm = PasswordViewModel()

    var isSuccess = BehaviorRelay<Bool>(value: false)
    var isLoading = BehaviorRelay<Bool>(value: false)
    var isAuthenticated = BehaviorRelay<Bool>(value: false)
    var errorMessage = BehaviorRelay<String>(value: "")
    
    func isValidCredentials() -> Bool {
        return emailvm.validateCredentials() && passwordvm.validateCredentials()
    }
    
    func loginUser(_ origin: UIViewController) {
        model.email = emailvm.data.value
        model.password = passwordvm.data.value
        
        isLoading.accept(true)
        
        
        auth.signIn(withEmail: model.email, password: model.password) { [weak self] authResult, error in
            if error != nil {
                self?.errorMessage.accept(error!.localizedDescription)
                self!.isLoading.accept(false)
            } else {
                let destination = HomeViewController()
                
                self!.isLoading.accept(false)
                self!.isSuccess.accept(true)

                destination.modalPresentationStyle = .overFullScreen
                origin.present(destination, animated: true, completion: nil)
            }
        }
    }
    
    func logoutUser(_ origin: UIViewController) {
        model.email = ""
        model.password = ""
        
        isLoading.accept(true)
        
        do {
            try auth.signOut()
            
            DispatchQueue.main.async {
                self.isLoading.accept(false)
                self.isSuccess.accept(true)
                self.isAuthenticated.accept(false)
                
                origin.dismiss(animated: true, completion: nil)
            }
        } catch let signOutError as NSError {
            self.isLoading.accept(false)
            self.errorMessage.accept(signOutError.localizedDescription)
        }
    }
}

struct PasswordViewModel: ValidateCredentials {
    var errorMessage: String = "Password field should not be empty"
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    func validateCredentials() -> Bool {
        guard validateLength(text: data.value, size: (5, 100)) else {
            errorValue.accept(errorMessage)

            return false
        }
    
        errorValue.accept("")

        return true
    }

    func validateLength(text : String, size : (min : Int, max : Int)) -> Bool {
        return (size.min...size.max).contains(text.count)
    }
}

struct EmailViewModel: ValidateCredentials {
    var errorMessage: String = "Please enter a valid email"
    var data: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    func validateCredentials() -> Bool {
        guard validatePattern(text: data.value) else {
            errorValue.accept(errorMessage)
 
            return false
        }
        
        errorValue.accept("")

        return true
    }

    func validatePattern(text : String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailInput = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailInput.evaluate(with: text)
    }
}

protocol ValidateCredentials {
    var errorMessage: String { get }
    
    var data: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get }
    
    func validateCredentials() -> Bool
}
