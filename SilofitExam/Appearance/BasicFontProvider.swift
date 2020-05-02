//
//  BasicFontProvider.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

enum FontName {
    case smallRegular
    case mediumRegular
    case largeRegular
    case smallBold
    case mediumBold
    case largeBold
}

protocol FontProvider {
    func fontForName(_ name: FontName) -> UIFont
}

final class BasicFontProvider: FontProvider {
    private lazy var fonts: [FontName: UIFont] = [.smallRegular: .systemFont(ofSize: 16),
                                                  .mediumRegular: .systemFont(ofSize: 18),
                                                  .largeRegular: .systemFont(ofSize: 22),
                                                  .smallBold: .systemFont(ofSize: 16, weight: .bold),
                                                  .mediumBold: .systemFont(ofSize: 18, weight: .bold),
                                                  .largeBold: .systemFont(ofSize: 22, weight: .bold)]
    func fontForName(_ name: FontName) -> UIFont {
        return fonts[name] ?? .systemFont(ofSize: 14)
    }
}
