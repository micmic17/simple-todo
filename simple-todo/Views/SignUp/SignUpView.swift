//
//  SignUpView.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/13/21.
//

import UIKit

class SignUpView: UIView {
    var submitAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        let mainStackView = setUpStackViews()

        self.addSubview(backgroundImage)
        addSubview(mainStackView)
        
        backgroundImage.setAnchor(top: self.topAnchor,
                                  left: self.leftAnchor,
                                  bottom: self.bottomAnchor,
                                  right: self.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0)
    
        mainStackView.setAnchor(width: self.frame.width - 60, height: mainStackView.frame.height)
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setUpStackViews() -> UIStackView {
        let firstNameStack = createStackView(views: [firstNameTextField, firstNameLabel], .vertical, .fillEqually, 5)
        let lastNameStack = createStackView(views: [lastNameTextField, lastNameLabel], .vertical, .fillEqually, 5)
        let ageStack = createStackView(views: [ageTextField, ageLabel], .vertical, .fillEqually, 5)
        let mobileStack = createStackView(views: [mobileTextField, mobileLabel], .vertical, .fillEqually, 5)
        let emailStack = createStackView(views: [emailTextField, emailLabel], .vertical, .fillEqually , 5)
        let passwordStack = createStackView(views: [passwordTextField, passwordLabel], .vertical, .fillEqually , 5)
        let firstMiddleStackView = createStackView(views: [firstNameStack, middleNameTextField], .horizontal, .fillEqually, 10)
        let lastSuffixStackView = createStackView(views: [lastNameStack, suffixTextField], .horizontal, .fillProportionally, 10)
        let ageMobileStackView = createStackView(views: [ageStack, mobileStack], .horizontal, .fillProportionally, 10)
        let buttonStackView = createStackView(views: [submitButton, cancelButton], .horizontal, .fillProportionally, 10)
    
        let mainStackView = createStackView(
            views: [pageTitle,
                    firstMiddleStackView,
                    lastSuffixStackView,
                    ageMobileStackView,
                    addressTextField,
                    emailStack,
                    passwordStack,
                    buttonStackView
            ], .vertical, .fillProportionally, 10)
        
        return mainStackView
    }

    // MARK: - Views
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        return label
    }()
    
    let firstNameTextField: UITextField = {
        let textfield = UITextField(placeHolder: "First Name")
        
        return textfield
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel(title: "First Name field should not be empty")
        
        return label
    }()
    
    let middleNameTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Middle Name")
        
        return textfield
    }()
    
    let lastNameTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Last Name")
        
        return textfield
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel(title: "Last Name field should not be empty")
        
        return label
    }()
    
    let suffixTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Suffix")
        textfield.setAnchor(width: 80, height: 40)
        
        return textfield
    }()
    
    let ageTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Age")
        textfield.setAnchor(width: 80, height: 40)
        
        return textfield
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel(title: "You should be at least 12 years old")
        
        return label
    }()

    let mobileTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Mobile Number")
        
        return textfield
    }()
    
    let mobileLabel: UILabel = {
        let label = UILabel(title: "Mobile number format should be PH format (63)")
        
        return label
    }()
    
    let addressTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Address")
        
        return textfield
    }()

    let emailTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Email")
        textfield.autocapitalizationType = .none
        
        return textfield
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel(title: "Email field should not be empty")
        
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField(placeHolder: "Password", isPassword: true)
        
        return textfield
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel(title: "Password field should not be empty")
        
        return label
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(title: "Register", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(title: "Cancel", borderColor: .redBorderColor)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSubmit() { submitAction?() }
    @objc func handleCancel() { cancelAction?() }
}
