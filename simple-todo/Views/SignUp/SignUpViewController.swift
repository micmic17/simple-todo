//
//  SignUpViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/13/21.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class SignUpViewController: UIViewController {
    var signUpView: SignUpView!
    let viewModel = SignUpViewModel(usingService: SignUpService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addTargets()
        defaultValue()
    }
    
    func setUpViews() {
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        view.addSubview(signUpView)
        
        self.viewModel.outputs.userID.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] response in
                if !response.isEmpty {
                    let message = "Test: " + response
                    let alert = UIAlertController(title: nil,
                                                  message: message,
                                                  preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default, handler: { _ in
                        self?.resetFields()
                        
                        DispatchQueue.main.async {
                            if self?.viewModel.userID != nil {
                                self?.redirectTo()
                            }
                        }
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        
        self.viewModel.outputs.submitButtonEnabled
            .observe(on: UIScheduler())
            .observeValues { [weak self] enabled in
                print(enabled)
                self?.signUpView.submitButton.isEnabled = enabled
            }
        
        self.viewModel.inputs.viewDidLoad()
    }
    
    func resetFields() {
        signUpView.emailTextField.text = nil
        signUpView.passwordTextField.text = nil
        signUpView.firstNameTextField.text = nil
        signUpView.middleNameTextField.text = nil
        signUpView.lastNameTextField.text = nil
        signUpView.suffixTextField.text = nil
        signUpView.ageTextField.text = nil
        signUpView.genderTextField.text = nil
        signUpView.mobileTextField.text = nil
        signUpView.addressTextField.text = nil
    }
    
    func defaultValue() {
        signUpView.emailTextField.text = "saturre.mic2@gmail.com"
        signUpView.passwordTextField.text = "test123"
        signUpView.firstNameTextField.text = "Mickale"
        signUpView.middleNameTextField.text = ""
        signUpView.lastNameTextField.text = "Saturre"
        signUpView.suffixTextField.text = ""
        signUpView.ageTextField.text = "23"
        signUpView.genderTextField.text = "Male"
        signUpView.mobileTextField.text = "09989496713"
        signUpView.addressTextField.text = "Saint Bernard Southern Leyte"
    }
    
    func redirectTo() {
        let homeVC = HomeViewController()
        
        homeVC.modalPresentationStyle = .overFullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
}

extension SignUpViewController {
    func addTargets() {
        signUpView.emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        signUpView.passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        signUpView.firstNameTextField.addTarget(self, action: #selector(firstNameChanged), for: .editingChanged)
        signUpView.middleNameTextField.addTarget(self, action: #selector(middleNameChanged), for: .editingChanged)
        signUpView.lastNameTextField.addTarget(self, action: #selector(lastNameChanged), for: .editingChanged)
        signUpView.suffixTextField.addTarget(self, action: #selector(suffixChanged), for: .editingChanged)
        signUpView.ageTextField.addTarget(self, action: #selector(ageChanged), for: .editingChanged)
        signUpView.genderTextField.addTarget(self, action: #selector(genderChanged), for: .editingChanged)
        signUpView.mobileTextField.addTarget(self, action: #selector(mobileNumberChanged), for: .editingChanged)
        signUpView.addressTextField.addTarget(self, action: #selector(addressChanged), for: .editingChanged)
        signUpView.submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        signUpView.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    @objc func emailChanged() {
        viewModel.inputs.emailChanged(email: signUpView.emailTextField.text)
    }
    
    @objc func passwordChanged() {
        viewModel.inputs.passwordChanged(password: signUpView.passwordTextField.text)
    }
    
    @objc func firstNameChanged() {
        viewModel.inputs.firstNameChanged(firstName: signUpView.firstNameTextField.text)
    }
    
    @objc func middleNameChanged() {
        viewModel.inputs.middleNameChanged(middleName: signUpView.middleNameTextField.text)
    }
    
    @objc func lastNameChanged() {
        viewModel.inputs.lastNameChanged(lastName: signUpView.lastNameTextField.text)
    }
    
    @objc func suffixChanged() {
        viewModel.inputs.suffixChanged(suffix: signUpView.suffixTextField.text)
    }
    
    @objc func ageChanged() {
        viewModel.inputs.ageChanged(age: signUpView.ageTextField.text)
    }
    
    @objc func genderChanged() {
        viewModel.inputs.genderChanged(gender: signUpView.genderTextField.text)
    }
    
    @objc func mobileNumberChanged() {
        viewModel.inputs.mobileNumberChanged(mobileNumber: signUpView.mobileTextField.text)
    }
    
    @objc func addressChanged() {
        viewModel.inputs.addressChanged(address: signUpView.addressTextField.text)
    }
    
    @objc func submitPressed() {
        viewModel.inputs.submitButtonPressed()
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}
