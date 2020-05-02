//
//  SpaceStatus.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

enum SpaceStatus: String {
    case opened
    case comingSoon = "coming_soon"
    case closed
    case unknown
    
    init(string: String) {
        self = SpaceStatus(rawValue: string.lowercased()) ?? .unknown
    }
}
