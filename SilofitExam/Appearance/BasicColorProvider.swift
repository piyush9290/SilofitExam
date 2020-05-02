//
//  BasicColorProvider.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct ColorConstant {
    static let mainBieze = UIColor(fromRGB: 206, green: 155, blue: 108)
}

enum ColorType {
    case main
    case light
    case dark
}

protocol ColorProvider {
    func colorForType(_ type: ColorType) -> UIColor
}

final class BasicColorProvider: ColorProvider {
    lazy var colors: [ColorType: UIColor] = [.main: ColorConstant.mainBieze,
                                             .light: .white,
                                             .dark: .black]
    
    func colorForType(_ type: ColorType) -> UIColor {
        colors[type] ?? .white
    }
}
