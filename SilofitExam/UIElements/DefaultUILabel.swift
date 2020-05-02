//
//  DefaultUILabel.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

class DefaultUILabel: UILabel {
    init(frame: CGRect,
                numberOfLines: Int = 0) {
        super.init(frame: frame)
        self.numberOfLines = numberOfLines
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
