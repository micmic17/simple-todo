//
//  LoginViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    let viewModel = LoginViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewModelBinding()
        createCallbacks()
    }
    
    func createViewModelBinding() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailvm.data)
            .disposed(by: disposedBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.emailvm.data)
            .disposed(by: disposedBag)
        
        loginButton.rx.tap.do(onNext: { [unowned self] in
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        }).subscribe(onNext: { [unowned self] in
            if self.viewModel.isValidCredentials() {
                self.viewModel.loginUser()
            }
        }).disposed(by: disposedBag)
    }
    
    func createCallbacks() {
        viewModel.isSuccess.asObservable()
            .bind{ value in
                NSLog("Successfull")
            }.disposed(by: disposedBag)

        viewModel.errorMessage.asObservable()
            .bind { errorMessage in
                NSLog("Failure")
            }.disposed(by: disposedBag)
    }
}
