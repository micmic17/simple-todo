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
        let emailStack = createStackView(views: [emailTextField, emailLabel], .vertical, .fillEqually , 5)
        let passwordStack = createStackView(views: [passwordTextField, passwordLabel], .vertical, .fillEqually , 5)

        let stackView = createStackView(views: [emailStack, passwordStack, loginButton, signUpButton], .vertical, .fillProportionally , 10)
        addSubview(backgroundImage)
        addSubview(stackView)
        backgroundImage.setAnchor(top: self.topAnchor,
                                  left: self.leftAnchor,
                                  bottom: self.bottomAnchor,
                                  right: self.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0)
        
        stackView.setAnchor(width: self.frame.width - 60, height: stackView.frame.height)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    // MARK: - Views
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Email")
        textfield.autocapitalizationType = .none
        
        return textfield
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel(title: "Email should not be empty")
        
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel(title: "Password should not be empty")
        
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Password", isPassword: true)
        
        return textfield
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(title: "Login", borderColor: UIColor.greenBorderColor)
        
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(title: "Sign Up", borderColor: UIColor.redBorderColor)
        
        return button
    }()
}
