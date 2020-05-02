//
//  MapViewUseCase.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct MapViewUseCaseConfig {
    let theme: Theme
    let spacesInfoProvider: SpaceInfoStorage
    let authenticateService: Authenticator
    let deleteUserInfoService: LoginUserInfoSaver
    let backAction: VoidClosure?
    let listTapAction: VoidClosure?
}

final class MapViewUseCase: Routable {
    var viewController: UIViewController { output }
    let output: MapViewController
    let interactor: Readyable
    
    init(config: MapViewUseCaseConfig) {
        let logoutAction: VoidClosure = {
            config.authenticateService.signOut { (result) in
                result.do(work: { _ in
                    config.deleteUserInfoService.deleteUserInfo()
                    config.backAction?()
                })
            }
        }
        let navModel = NavigationBarModel(leftModel: .init(title: "Log out", action: logoutAction),
                                          righModel: .init(title: "List", action: config.listTapAction))
        output = MapViewController(theme: config.theme,
                                   navModel: navModel)
        interactor = MapViewInteractorImp(output: output,
                                          spacesInfoProvider: config.spacesInfoProvider)
        output.input = interactor
    }
}
