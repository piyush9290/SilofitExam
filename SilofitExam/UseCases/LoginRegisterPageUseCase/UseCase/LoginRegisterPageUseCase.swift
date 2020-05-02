//
//  LoginRegisterPageUseCase.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct LoginRegisterPageUseCaseConfig: LoginRegisterPageInteractorConfig, LoginRegisterPagePresenterConfig {
    let theme: Theme
    let authenticateService: Authenticator
    let userCreatorService: UserCreator
    let loginInfoSaverService: LoginUserInfoSaver
    let actionType: ActionType
    let backAction: VoidClosure?
    let completion: VoidClosure?
}

class LoginRegisterPageUseCase: Routable {
    var viewController: UIViewController { output }
    private let output: LoginRegisterPageViewController
    private let presenter: LoginRegisterPagePresenter
    private let interactor: LoginRegisterPageInteractor
    
    init(config: LoginRegisterPageUseCaseConfig) {
        let navModel = NavigationBarModel(leftModel: .init(image: StaticImageStorage.backButtonImage, action: config.backAction),
                                          righModel: .empty)
        output = LoginRegisterPageViewController(theme: config.theme,
                                                 navModel: navModel)
        presenter = LoginRegisterPagePresenterImp(output: output,
                                                  config: config)
        interactor = LoginRegisterPageInteractorImp(presenter: presenter,
                                                    config: config)
        output.input = interactor
    }
}
