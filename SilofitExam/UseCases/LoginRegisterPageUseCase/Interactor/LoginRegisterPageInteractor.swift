//
//  LoginRegisterPageInteractor.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

enum LoginRegisterPageInteractorError: LocalizedError {
    case emptyField
    case success(String)
    
    var errorDescription: String? {
        switch self {
        case .emptyField: return "Missing email or password"
        case let .success(id): return "UserId: \(id)"
        }
    }
}

protocol LoginRegisterPageInteractorConfig {
    var authenticateService: Authenticator { get }
    var userCreatorService: UserCreator { get }
    var loginInfoSaverService: LoginUserInfoSaver { get }
    var actionType: ActionType { get }
    var completion: VoidClosure? { get }
}

protocol Readyable: class {
    func isReady()
}

protocol LoginRegisterPageInteractor: Readyable {
    func loginRegister(model: LoginRegisterInputModel)
}

class LoginRegisterPageInteractorImp: LoginRegisterPageInteractor {
    private let presenter: LoginRegisterPagePresenter
    private let config: LoginRegisterPageInteractorConfig
    
    init(presenter: LoginRegisterPagePresenter,
         config: LoginRegisterPageInteractorConfig) {
        self.presenter = presenter
        self.config = config
    }
    
    func isReady() {
        let model = LoginRegisterPagePresenterModel(buttonType: config.actionType)
        presenter.present(model: model)
    }
    
    func loginRegister(model: LoginRegisterInputModel) {
        switch config.actionType {
        case .join: join(model: model)
        case .login: signIn(model: model)
        }
    }
    
    private func verifyInputInfo(model: LoginRegisterInputModel) {
        guard model.userEmail.isEmpty || model.password.isEmpty else { return }
        presenter.present(error: LoginRegisterPageInteractorError.emptyField)
    }
    
    private func signIn(model: LoginRegisterInputModel) {
        config.authenticateService.authenticate(withEmail: model.userEmail,
                                                password: model.password,
                                                completion: { [weak self] in self?.processResult(result: $0) })
    }
    
    private func join(model: LoginRegisterInputModel) {
        config.userCreatorService.createUser(withEmail: model.userEmail,
                                             password: model.password,
                                             completion: { [weak self] in self?.processResult(result: $0) })
    }
    
    private func processResult(result: ALResult<String>) {
        result.do(work: { self.saveUserInfo($0) })
              .onError({ self.presenter.present(error: $0) })
    }
    
    private func saveUserInfo(_ string: String) {
        config.loginInfoSaverService.saveUserInfo(id: string)
        presenter.present(error: LoginRegisterPageInteractorError.success(string))
        config.completion?()
    }
}
