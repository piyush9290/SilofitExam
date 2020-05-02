//
//  RootTransitionFactory.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer

final class RootTransitionFactory: TransitionFactoryTemplate<RootRouterState> {
    override func transition(from: RootRouterState, nextState: RootRouterState) -> TransitionProvider {
        return animationProvider.provider(for: .noAnimation, dimmingViewType: .noDimming)
    }
}
