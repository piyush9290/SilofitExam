//
//  NavigationRouter.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer
import RouterStateMachine
import EitherResult

protocol NavigationRouterFactory {
    associatedtype State
    typealias Container = Routable & VCContainer
    var container: NavigationRouterFactory.Container { get }
    func routableForState(_ state: State) -> ALResult<Routable>
    func subrouterForState(_ state: State) -> ALResult<Routable & RoutingStartable>
}

protocol TransitionRouterFactory {
    associatedtype State
    func transition(from: State, nextState: State) -> TransitionProvider
}

class NavigationRouter<Provider: StateProvider,
                       Factory: NavigationRouterFactory,
                       TransitionFactory: TransitionRouterFactory>: RouterTemplate<Provider>
where Provider.T == Factory.State, Factory.State == TransitionFactory.State {

    typealias Container = Routable & VCContainer
    typealias State = Provider.T
    let container: Container
    let provider: Provider
    let factory: Factory
    let transitionFactory: TransitionFactory
    private(set) var routables: [Routable] = []

    init(container: Container,
         provider: Provider,
         factory: Factory,
         transitionFactory: TransitionFactory,
         initialState: State) {

        self.container = container
        self.provider = provider
        self.factory = factory
        self.transitionFactory = transitionFactory
        super.init(initialState: initialState, roadMapProvider: provider)
    }

    override func willMove(from: Provider.T,
                           to nextState: Provider.T,
                           with completion: @escaping VoidClosure) {
        fatalError("Subclasses must override")
    }

    func popRoutable(fromState from: State,
                     toState to: State,
                     completion: @escaping VoidClosure) {
        let transition = getTransition(fromState: from, toState: to)
        routables.removeLastSafe()
        _ = container.pop(using: transition, completion: { _ in completion() })
    }

    func getTransition(fromState from: State, toState to: State) -> TransitionProvider {
        return transitionFactory.transition(from: from, nextState: to)
    }

    func pushRoutableForState(state to: State,
                              fromState from: State,
                              withCompletion completion: @escaping VoidClosure) {
        let transition = getTransition(fromState: from, toState: to)
        factory.routableForState(to).do(work: {
            self.pushRoutable($0,
                              usingTransition: transition,
                              completion: completion)
        })
    }

    func setRootRoutableForState(state to: State,
                                 fromState from: State,
                                 withCompletion completion: @escaping VoidClosure) {
        let transition = getTransition(fromState: from, toState: to)
        factory.routableForState(to).do(work: {
            self.setRootRoutable($0,
                                 usingTransition: transition,
                                 completion: completion)
        })

    }

    private func setRootRoutable(_ routable: Routable,
                                 usingTransition transition: TransitionProvider,
                                 completion: @escaping VoidClosure) {
        routables = [routable]
        container.show(routable.viewController,
                       using: transition,
                       completion: { _ in completion() })
    }

    private func pushRoutable(_ routable: Routable,
                              usingTransition transition: TransitionProvider,
                              completion: @escaping VoidClosure) {
        routables.append(routable)
        container.push(controller: routable.viewController,
                       with: transition,
                       completion: { _ in completion() })
    }

    func pushSubrouterForState(_ to: State,
                               fromState from: State,
                               completion: @escaping VoidClosure) {
        let transition = getTransition(fromState: from, toState: to)
        factory.subrouterForState(to).do(work: {
            self.passControlToSubrouter($0,
                                        usingTransition: transition,
                                        completion: completion)
        })
    }

    private func passControlToSubrouter(_ subrouter: RoutingStartable & Routable,
                                        usingTransition transition: TransitionProvider,
                                        completion: @escaping VoidClosure) {
        pushRoutable(subrouter, usingTransition: transition) {
            subrouter.start()
            completion()
        }
    }
}
