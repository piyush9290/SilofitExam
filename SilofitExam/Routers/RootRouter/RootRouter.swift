//
//  RootRouter.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer
import EitherResult
import RouterStateMachine

final class RootRouter: NavigationRouter<RootRouterMapProvider, RootRouterFactory, RootTransitionFactory> {
    
    init(userInfoServiceProvider: UserInfoServiceProvider, routableFactory: RootRouterFactory) {
        super.init(container: routableFactory.container,
                   provider: RootRouterMapProvider(),
                   factory: routableFactory,
                   transitionFactory: RootTransitionFactory(),
                   initialState: .initial)
        launchUseCase(usingInfo: userInfoServiceProvider.userInfo)
    }
    
    override func willMove(from: RootRouterState,
                           to nextState: RootRouterState,
                           with completion: @escaping VoidClosure) {
        switch (from, nextState) {
        case (.initial, .landingPageUseCase),
             (.landingPageUseCase, .loginRegisterPageUseCase),
             (.initial, .mapUseCase),
             (.loginRegisterPageUseCase, .mapUseCase):
            pushRoutableForState(state: nextState, fromState: from, withCompletion: completion)
        case (.loginRegisterPageUseCase, .landingPageUseCase):
            popRoutable(fromState: from, toState: nextState, completion: completion)
        default: fatalError()
        }
    }
    
    private func launchUseCase(usingInfo userInfo: ALResult<UserInfo>) {
        userInfo.do(work: { _ in self.pushMapViewUseCase() })
                .onError({ _ in self.pushLandingPageUseCase() })
    }
    
    private func pushLandingPageUseCase() {
        let signInAction: VoidClosure = { [weak self] in
            self?.pushLoginPageUseCase(type: .login)
        }
        let joinAction: VoidClosure = { [weak self] in
            self?.pushLoginPageUseCase(type: .join)
        }
        let actionConfig = LandingPageUseCaseActionConfig(signInAction: signInAction,
                                                          joinNowAction: joinAction)
        pushState(.landingPageUseCase(actionConfig))
    }
    
    private func pushLoginPageUseCase(type: ActionType) {
        let completion: VoidClosure = { [weak self] in
            self?.pushMapViewUseCase()
        }
        let backAction: VoidClosure = { [weak self] in
            self?.back()
        }
        pushState(.loginRegisterPageUseCase(type: type, backAction: backAction, completion: completion))
    }
    
    private func pushMapViewUseCase() {
        pushState(.mapUseCase)
    }
    
    private func back() {
        self.popLastState()
    }
}
