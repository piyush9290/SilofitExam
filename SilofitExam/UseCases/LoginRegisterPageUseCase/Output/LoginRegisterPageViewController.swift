//
//  LoginRegisterPageViewController.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

class LoginRegisterPageViewController: NavigationContainer {
    let statusMessageLabel: UILabel = DefaultUILabel(frame: .zero)
    let userEmailTextField: UITextField = UITextField(frame: .zero)
    let passwordTextField: UITextField = UITextField(frame: .zero)
    let loginJoinButton: DefaultRoundedButton = DefaultRoundedButton(frame: .zero)
    
    let contentView: UIView = UIView(frame: .zero)
    
    weak var input: LoginRegisterPageInteractor?
    
    init(theme: Theme, navModel: NavigationBarModel) {
        let navigationFactory = NavigationConfigFactory(theme: theme)
        let navigationConfig = navigationFactory.getNavigationConfig(fromModel: navModel)
        super.init(navigationConfig: navigationConfig,
                   containerView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        setTextFieldUIParameters(userEmailTextField)
        setTextFieldUIParameters(passwordTextField, isSecure: true)
        input?.isReady()
    }
    
    private func setUpUI() {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        stackView.addArrangedSubview(userEmailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginJoinButton)
        
        contentView.addSubview(stackView)
        contentView.addSubview(statusMessageLabel)
        
        userEmailTextField.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        userEmailTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        loginJoinButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        loginJoinButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9).isActive = true
        loginJoinButton.addTarget(self, action: #selector(loginRegisterButtonTap), for: .touchUpInside)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        
        statusMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        statusMessageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        statusMessageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        statusMessageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        statusMessageLabel.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.topAnchor).isActive = true
    }
    
    private func setTextFieldUIParameters(_ textField: UITextField, isSecure: Bool = false) {
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = .none
    }
    
    @objc private func loginRegisterButtonTap() {
        let userEmail = userEmailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let inputModel = LoginRegisterInputModel(userEmail: userEmail,
                                                 password: password)
        input?.loginRegister(model: inputModel)
    }
}

protocol LoginRegisterPageOutput {
    func display(_ model: LoginRegisterPageOutputModel)
    func displayStatus(withConfig config: TextLabelConfig)
}

extension LoginRegisterPageViewController: LoginRegisterPageOutput {
    func display(_ model: LoginRegisterPageOutputModel) {
        statusMessageLabel.accept(config: model.statusMessageConfig)
        userEmailTextField.accept(config: model.userEmailConfig)
        passwordTextField.accept(config: model.passwordConfig)
        loginJoinButton.accept(config: model.loginJoinButtonConfig)
    }
    
    func displayStatus(withConfig config: TextLabelConfig) {
        statusMessageLabel.accept(config: config)
    }
}
