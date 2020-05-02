//
//  NavigationConfigFactory.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarModel {
    let leftModel: ButtonModel
    let righModel: ButtonModel
    
    struct ButtonModel {
        let title: String
        let image: UIImage?
        let action: VoidClosure?
        
        init(title: String = "",
             image: UIImage? = nil,
             action: VoidClosure?) {
            self.title = title
            self.image = image
            self.action = action
        }
        
        static var empty: ButtonModel {
            .init(title: "", image: nil, action: nil)
        }
    }
}

final class NavigationConfigFactory {
    private let theme: Theme
    init(theme: Theme) {
        self.theme = theme
    }
    
    func getNavigationConfig(fromModel barModel: NavigationBarModel) -> NavigationConfig {
        let leftConfig = getButtonConfig(model: barModel.leftModel)
        let rightConfig = getButtonConfig(model: barModel.righModel)
        return .init(leftButtonConfig: leftConfig,
                     rightButtonConfig: rightConfig,
                     backgroundColor: theme.colorForType(.light))
    }
    
    private func getButtonConfig(model: NavigationBarModel.ButtonModel) -> ButtonConfig {
        ButtonConfig(title: [.normal: model.title],
                     titleTextColor: [.normal: theme.colorForType(.main)],
                     titleFont: theme.fontForName(.mediumBold),
                     image: [.normal: model.image],
                     backgroundColor: [.normal: theme.colorForType(.light)],
                     tintColor: theme.colorForType(.main),
                     isEnabled: true,
                     contentVerticalAlignment: .bottom,
                     tapClosure: model.action)
    }
}
