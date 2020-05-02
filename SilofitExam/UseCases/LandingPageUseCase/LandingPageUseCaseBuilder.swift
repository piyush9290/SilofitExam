//
//  LandingPageUseCaseBuilder.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct LandingPageUseCaseConfig {
    let theme: Theme
    let actionConfig: LandingPageUseCaseActionConfig
}

struct LandingPageUseCaseActionConfig {
    let signInAction: VoidClosure?
    let joinNowAction: VoidClosure?
}

class LandingPageUseCaseBuilder {
    private let theme: Theme
    private let actionConfig: LandingPageUseCaseActionConfig
    init(config: LandingPageUseCaseConfig) {
        self.theme = config.theme
        self.actionConfig = config.actionConfig
    }
    
    var controller: LandingPageViewController {
        .init(config: controllerConfig)
    }
    
    private var controllerConfig: LandingPageViewConfig {
        let joinButtonConfig = getButtonConfig(title: "Join now",
                                               textColor: theme.colorForType(.main),
                                               backgroundColor: theme.colorForType(.light),
                                               tapClosure: actionConfig.joinNowAction)
        let signInButtonConfig = getButtonConfig(title: "Sign in",
                                                 textColor: theme.colorForType(.light),
                                                 backgroundColor: theme.colorForType(.main),
                                                 tapClosure: actionConfig.signInAction)
        return .init(theme: theme,
                     joinButtonConfig: joinButtonConfig,
                     signInButtonConfig: signInButtonConfig)
    }
    
    private func getButtonConfig(title: String,
                                 textColor: UIColor,
                                 backgroundColor: UIColor,
                                 tapClosure: VoidClosure?) -> ButtonConfig {
        .init(title: [.normal: title],
              titleTextColor: [.normal: textColor],
              titleFont: theme.fontForName(.mediumBold),
              backgroundColor: [.normal: backgroundColor],
              tintColor: theme.colorForType(.light),
              tapClosure: tapClosure)
    }
}
