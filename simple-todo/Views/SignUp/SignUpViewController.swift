//
//  SignUpViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/13/21.
//

import UIKit

class SignUpViewController: UIViewController {
    var signUpView: SignUpView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    func setUpViews() {
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        self.signUpView.submitAction = submitPressed
        self.signUpView.cancelAction = cancelPressed
        view.addSubview(signUpView)
    }
    
    func submitPressed() { print("submit") }

    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}
