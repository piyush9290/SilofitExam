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
    let backAction: VoidClosure?
    let listTapAction: VoidClosure?
}

final class MapViewUseCase: Routable {
    var viewController: UIViewController { output }
    let output: MapViewController
    let interactor: Readyable
    
    init(config: MapViewUseCaseConfig) {
        let navModel = NavigationBarModel(leftModel: .init(title: "Log out", action: config.backAction),
                                          righModel: .init(title: "List", action: config.listTapAction))
        output = MapViewController(theme: config.theme,
                                   navModel: navModel)
        interactor = MapViewInteractorImp(output: output,
                                          spacesInfoProvider: config.spacesInfoProvider)
        output.input = interactor
    }
}
