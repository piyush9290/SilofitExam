//
//  AppInitializer.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer
import Firebase
import EitherResult

final class AppInitializer {
    private let window: UIWindow
    var rootRouter: RootRouter?
    private var serviceProvider: ServiceProviderType = ServiceProvider()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        initializeFirebase()
        launchUI()
    }
    
    private func launchUI() {
        let container = ALViewControllerContainer(initialVC: UIViewController())
        let factory = RootRouterFactory(serviceProvider: serviceProvider,
                                        _container: container,
                                        containerProvider: ContainerProviderImp())
        rootRouter = RootRouter(userInfoServiceProvider: serviceProvider,
                                routableFactory: factory)
        window.rootViewController = rootRouter?.container.viewController
        window.makeKeyAndVisible()
    }
    
    private func initializeFirebase() {
        FirebaseApp.configure()
    }
}
