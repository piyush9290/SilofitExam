//
//  BasicThemeProvider.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol Theme: ColorProvider, FontProvider { }

final class BasicThemeProvider: Theme {
    private let colorProvider: ColorProvider
    private let fontProvider: FontProvider
    
    init(colorProvider: ColorProvider,
         fontProvider: FontProvider) {
        self.colorProvider = colorProvider
        self.fontProvider = fontProvider
    }
    
    func colorForType(_ type: ColorType) -> UIColor {
        colorProvider.colorForType(type)
    }
    
    func fontForName(_ name: FontName) -> UIFont {
        fontProvider.fontForName(name)
    }
}
