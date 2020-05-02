//
//  UIColor.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(fromRGB red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        self.init(displayP3Red: CGFloat(red)/255.0,
                  green: CGFloat(green)/255.0,
                  blue: CGFloat(blue)/255.0,
                  alpha: CGFloat(alpha))
    }
}
