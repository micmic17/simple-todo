//
//  LoginViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    var mainView: LoginView! { return self.view as? LoginView }

    let viewModel = LoginViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewModelBinding()
        createCallbacks()
    }
    
    override func loadView() {
        self.view = LoginView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = size.width > size.height
        if isLandscape {
            mainView.centerContentStack.axis = .horizontal
        } else {
            mainView.centerContentStack.axis = .vertical
        }
    }

    // MARK: - Reactive functions
    func createViewModelBinding() {
        mainView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailvm.data)
            .disposed(by: disposedBag)
        
        mainView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordvm.data)
            .disposed(by: disposedBag)
        
        mainView.loginButton.rx.tap.do(onNext: { [unowned self] in
            self.mainView.emailTextField.resignFirstResponder()
            self.mainView.passwordTextField.resignFirstResponder()
        }).subscribe(onNext: { [unowned self] in
            if self.viewModel.isValidCredentials() {
                self.viewModel.loginUser()
                
            } else {
                print("wala ni sulod")
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
