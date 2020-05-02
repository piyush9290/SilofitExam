//
//  TextLabelConfig.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct TextLabelConfig: Equatable {
    let color: UIColor
    let font: UIFont
    let string: String?
    let attributedString: NSAttributedString?
    let backgroundColor: UIColor
    let textAlignment: NSTextAlignment?

    static var defaultConfig: TextLabelConfig {
        .init(color: .black,
              font: .systemFont(ofSize: 11),
              string: "",
              backgroundColor: .white)
    }

    init(color: UIColor,
         font: UIFont,
         string: String?,
         attributedString: NSAttributedString? = nil,
         textAlignment: NSTextAlignment? = nil,
         backgroundColor: UIColor) {
        self.color = color
        self.font = font
        self.string = string
        self.attributedString = attributedString
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
    }
}

extension UILabel {
    func accept(config: TextLabelConfig) {
        font = config.font
        textColor = config.color
        backgroundColor = config.backgroundColor
        config.string.do({ [weak self] in self?.text = $0 })
        config.attributedString.do({ [weak self] in self?.attributedText = $0 })
        config.textAlignment.do({ [weak self] in  self?.textAlignment = $0 })
    }
}
