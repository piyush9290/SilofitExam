//
//  ControllerType.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import AHContainer

enum ControllerType {
    case main
    case alert(SizeProportion)
    case unknown
}

extension SizeProportion {
    static var defaultAlert: SizeProportion {
        return SizeProportion(width: 0.9, height: 0.5)
    }
}
