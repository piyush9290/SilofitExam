//
//  RootRouterMapProvider.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import RouterStateMachine

final class RootRouterMapProvider: StateProvider {
    typealias T = RootRouterState

    func canMove(fromState state: RootRouterState, toState nextState: RootRouterState) -> Bool {
        switch (state, nextState) {
        case (.initial, .landingPageUseCase),
             (.landingPageUseCase, .loginRegisterPageUseCase),
             (.loginRegisterPageUseCase, .landingPageUseCase),
             (.initial, .mapUseCase),
             (.loginRegisterPageUseCase, .mapUseCase),
             (.mapUseCase, .landingPageUseCase): return true
        default: return false
        }
    }
}
