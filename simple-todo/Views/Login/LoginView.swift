//
//  LoginView.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit

class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setup() {
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        self.addSubview(backgroundView)
        self.addSubview(mainStack)
        
        mainStack.addArrangedSubview(centerContentStack)
        centerContentStack.addArrangedSubview(emailLabel)
        centerContentStack.addArrangedSubview(emailTextField)
        centerContentStack.addArrangedSubview(passwordLabel)
        centerContentStack.addArrangedSubview(passwordTextField)
        mainStack.addArrangedSubview(loginButton)
    }
    
    private func setUpConstraints() {
        backgroundView.pinEdges(to: self)
        mainStack.pinEdgesToSafeArea(of: self)
    }
    
    // MARK: - Views
    let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()

    let mainStack: UIStackView = {
        let stackView = UIStackView(frame: .infinite)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 30, bottom: 30, right: 30)

        return stackView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Email"

        return label
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 10, y: 320, width: 300, height: 30))
        textfield.placeholder = "Email"
        textfield.defaultTextField(textfield)

        return textfield
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Password"

        return label
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 10, y: 320, width: 300, height: 30))
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.defaultTextField(textfield)

        return textfield
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 80)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let centerContentStack: UIStackView = {
        let stackView = UIStackView(frame: .infinite)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
}

extension UITextField {
    func defaultTextField(_ textfield: UITextField) {
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.textColor = UIColor.black
    }
}
