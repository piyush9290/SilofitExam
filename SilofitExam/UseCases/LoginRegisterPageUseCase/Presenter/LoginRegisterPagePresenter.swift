//
//  LoginRegisterPagePresenter.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

protocol LoginRegisterPagePresenterConfig {
    var theme: Theme { get }
}

protocol LoginRegisterPagePresenter {
    func present(model: LoginRegisterPagePresenterModel)
    func present(error: Error)
}

class LoginRegisterPagePresenterImp: LoginRegisterPagePresenter {
    
    private let output: LoginRegisterPageOutput
    private let config: LoginRegisterPagePresenterConfig
    
    init(output: LoginRegisterPageOutput, config: LoginRegisterPagePresenterConfig) {
        self.output = output
        self.config = config
    }
    
    func present(model: LoginRegisterPagePresenterModel) {
        let model = getOutputModel(buttonType: model.buttonType)
        output.display(model)
    }
    
    func present(error: Error) {
        let statusMessgageConfig = prepareStatusConfig(withMessage: error.localizedDescription)
        output.displayStatus(withConfig: statusMessgageConfig)
    }
}

extension LoginRegisterPagePresenterImp {
    private func getOutputModel(buttonType: ActionType) -> LoginRegisterPageOutputModel {
        let statusMessageConfig = prepareStatusConfig(withMessage: "")
        let userEmailConfig = textFieldConfig(placeHolderText: "User email")
        let passwordConfig = textFieldConfig(placeHolderText: "Password")
        let loginJoinButtonConfig = buttonConfig(fromType: buttonType)
        return .init(statusMessageConfig: statusMessageConfig,
                     userEmailConfig: userEmailConfig,
                     passwordConfig: passwordConfig,
                     loginJoinButtonConfig: loginJoinButtonConfig)
    }
    
    private func prepareStatusConfig(withMessage message: String) -> TextLabelConfig {
        .init(color: config.theme.colorForType(.dark),
              font: config.theme.fontForName(.mediumRegular),
              string: message,
              textAlignment: .center,
              backgroundColor: config.theme.colorForType(.light))
    }
    
    private func textFieldConfig(placeHolderText: String) -> TextFieldConfig {
        .init(textColor: config.theme.colorForType(.dark),
              text: nil,
              placeholder: placeHolderText,
              font: config.theme.fontForName(.mediumRegular))
    }
    
    private func buttonConfig(fromType type: ActionType) -> ButtonConfig {
        .init(title: [.normal: type.rawValue],
              titleTextColor: [.normal: config.theme.colorForType(.light)],
              titleFont: config.theme.fontForName(.mediumBold),
              backgroundColor: [.normal: config.theme.colorForType(.main)],
              tintColor: config.theme.colorForType(.light),
              tapClosure: nil)
    }
}
