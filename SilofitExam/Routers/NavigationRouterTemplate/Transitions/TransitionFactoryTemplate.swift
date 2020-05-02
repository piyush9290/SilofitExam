//
//  TransitionFactoryTemplate.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer

class TransitionFactoryTemplate<RouterState>: TransitionRouterFactory {
    typealias State = RouterState
    let animationProvider: DefaultAnimationProviderFactory

    init(animationProvider: DefaultAnimationProviderFactory = DefaultAnimationProviderFactory()) {
        self.animationProvider = animationProvider
    }

    func transition(from: State, nextState: State) -> TransitionProvider {
        fatalError("Subclasses Must Override ")
    }
}
