//
//  LoginViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    var loginView: LoginView!

    let viewModel = LoginViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        createViewModelBinding()
        createCallbacks()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.signUpAction = signUpPressed
        self.view.addSubview(loginView)
        loginView.setAnchor(top: view.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0)
    }

    func signUpPressed() { print("signup") }
    

    // MARK: - Reactive functions
    func createViewModelBinding() {
        loginView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailvm.data)
            .disposed(by: disposedBag)
        
        loginView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordvm.data)
            .disposed(by: disposedBag)
    
        loginView.loginButton.rx.tap.do(onNext: { [unowned self] in
            self.loginView.emailTextField.resignFirstResponder()
            self.loginView.passwordTextField.resignFirstResponder()
            self.loginView.loginButton.isEnabled = false
        })
        .subscribe(onNext: { [unowned self] in
            self.loginView.loginButton.isEnabled = true

            if self.viewModel.isValidCredentials() {
                self.viewModel.loginUser(self)
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
