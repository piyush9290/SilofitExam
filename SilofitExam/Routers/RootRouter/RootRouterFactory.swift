//
//  RootRouterFactory.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer
import EitherResult

final class RootRouterFactory: NavigationRouterFactory {
    var container: NavigationRouterFactory.Container { return _container }

    private let serviceProvider: ServiceProviderType
    private let _container: VCContainer & Routable
    private let containerProvider: ContainerProvider
    private var newContainer: NavigationRouterFactory.Container {
           return containerProvider.newContainer
    }

    init(serviceProvider: ServiceProviderType,
         _container: VCContainer & Routable,
         containerProvider: ContainerProvider) {
        self.serviceProvider = serviceProvider
        self._container = _container
        self.containerProvider = containerProvider
    }

    func routableForState(_ state: RootRouterState) -> ALResult<Routable> {
        switch state {
        case let .landingPageUseCase(actionConfig):
            return .right(landingPageUseCase(actionConfig))
        case let .loginRegisterPageUseCase(actionType, backAction, completion):
            return .right(loginRegisterPageUseCase(actionType, backAction, completion))
        case let .mapUseCase(backAction, nextAction):
            return .right(mapViewUseCase(backAction, nextAction))
        default: return .wrong(RouterError.unknownState(state))
        }
    }

    func subrouterForState(_ state: RootRouterState) -> ALResult<RoutingStartable & Routable> {
        switch state {
        default: return .wrong(RouterError.unknownState(state))
        }
    }
    
    private func landingPageUseCase(_ actionConfig: LandingPageUseCaseActionConfig) -> Routable {
        let config = LandingPageUseCaseConfig(theme: serviceProvider.theme,
                                              actionConfig: actionConfig)
        let builder = LandingPageUseCaseBuilder(config: config)
        return builder.controller
    }
    
    private func loginRegisterPageUseCase(_ actionType: ActionType,_ backAction: VoidClosure?,_ completion: VoidClosure?) -> Routable {
        let config = LoginRegisterPageUseCaseConfig(theme: serviceProvider.theme,
                                                    authenticateService: serviceProvider.authenticateService,
                                                    userCreatorService: serviceProvider.userCreatorService,
                                                    loginInfoSaverService: serviceProvider.userInfoSaverService,
                                                    actionType: actionType,
                                                    backAction: backAction,
                                                    completion: completion)
        return LoginRegisterPageUseCase(config: config)
    }
    
    private func mapViewUseCase(_ backAction: VoidClosure?,_ listTapAction: VoidClosure?) -> Routable {
        let config = MapViewUseCaseConfig(theme: serviceProvider.theme,
                                          spacesInfoProvider: serviceProvider.spaceInfoStorage,
                                          authenticateService: serviceProvider.authenticateService,
                                          deleteUserInfoService: serviceProvider.userInfoSaverService,
                                          backAction: backAction,
                                          listTapAction: listTapAction)
        return MapViewUseCase(config: config)
    }
}
