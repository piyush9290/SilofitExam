//
//  RoundedButton.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-27.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

class DefaultRoundedButton: BlockButton {
    var cornerRadiusHeightProportion = CGFloat(0.5)
    var lineThickness: CGFloat = 0.0
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = lineThickness
        layer.cornerRadius = layer.frame.height * cornerRadiusHeightProportion
        clipsToBounds = true
    }
}

class BorderedDefaultRoundedButton: DefaultRoundedButton {
    var borderColor = UIColor.clear
    override func layoutSubviews() {
        let allLinesColor = (isHighlighted || !isEnabled) ?
                             borderColor.withAlphaComponent(0.3) : borderColor
        super.layoutSubviews()
        layer.borderColor = allLinesColor.cgColor
        self.tintColor = allLinesColor
    }
}
