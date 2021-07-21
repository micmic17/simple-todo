//
//  LoginViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class LoginViewController: UIViewController {
    var loginView: LoginView!

    let viewModel = LoginViewModel(usingService: LoginService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addTargets()
        alertMessage()
    }

    func setUpView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(loginView)
        loginView.setAnchor(top: view.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0)

        loginView.emailLabel.isHidden = true
        loginView.passwordLabel.isHidden = true

        self.viewModel.outputs.loginButtonEnabled
                .observe(on: UIScheduler())
                .observeValues { [weak self] enabled in
                    self?.loginView.loginButton.isEnabled = enabled
                }
        self.viewModel.rootVC = self
        self.viewModel.inputs.viewDidLoad()
    }
    
    func alertMessage() {
        self.viewModel.outputs.alertMessage
            .observe(on: UIScheduler())
            .observeValues { [weak self] message in
                let alert = UIAlertController(title: nil,
                                              message: message,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OKAY", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
    }
}

extension LoginViewController {
    func addTargets() {
        loginView.emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
    }
    
    @objc func emailChanged() {
        self.viewModel.inputs.emailChanged(email: loginView.emailTextField.text)
    }

    @objc func passwordChanged() {
        self.viewModel.inputs.passwordChanged(password: loginView.passwordTextField.text)
    }
    @objc func loginButtonPressed() {
        self.viewModel.inputs.loginButtonPressed()
    }

    @objc func signUpPressed() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .overFullScreen
        signUpVC.modalTransitionStyle = .crossDissolve
        present(signUpVC, animated: true, completion: nil)
    }
}
