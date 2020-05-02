//
//  RootRouterState.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import RouterStateMachine

enum RootRouterState: State {
    var uniqueID: String { return "\(self)" }
    case initial
    case landingPageUseCase(LandingPageUseCaseActionConfig)
    case loginRegisterPageUseCase(type: ActionType, backAction: VoidClosure?, completion: VoidClosure?)
    case mapUseCase
}
