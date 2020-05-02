//
//  ContainerProvider.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer

protocol ContainerProvider {
    var newContainer: Routable & VCContainer { get }
}

protocol RoutingStartable {
    func start()
}

final class ContainerProviderImp: ContainerProvider {
    var newContainer: VCContainer & Routable { return ALViewControllerContainer(initialVC: UIViewController() ) }
}
