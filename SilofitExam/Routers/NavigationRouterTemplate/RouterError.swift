//
//  RouterError.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import RouterStateMachine

enum RouterError: LocalizedError {
    case unknownState(State)

    var errorDescription: String? {
        switch self {
        case let .unknownState(routerState): return "Unknown \(routerState.uniqueID) State"
        }
    }
}
