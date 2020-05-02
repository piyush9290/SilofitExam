//
//  TextFieldConfig.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct TextFieldConfig {
    let textColor: UIColor
    let text: String?
    let placeholder: String?
    let font: UIFont

    static var defaultConfig: TextFieldConfig {
        .init(textColor: .black,
              text: nil,
              placeholder: nil,
              font: .systemFont(ofSize: 11))
    }

    init(textColor: UIColor,
         text: String?,
         placeholder: String?,
         font: UIFont) {
        self.textColor = textColor
        self.text = text
        self.placeholder = placeholder
        self.font = font
    }
}

extension UITextField {
    func accept(config: TextFieldConfig) {
        textColor = config.textColor
        font = config.font
        config.text.do({ [weak self] in self?.text = $0 })
        config.placeholder.do({ [weak self] in self?.placeholder = $0 })
    }
}
