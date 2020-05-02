//
//  ButtonConfig.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-27.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIControl.State: Hashable { }

struct ButtonConfig {
    let title: [UIControl.State: String]
    let attributedTitle: [UIControl.State: NSAttributedString]?
    let titleTextColor: [UIControl.State: UIColor]
    let titleFont: UIFont
    let image: [UIControl.State: UIImage?]
    let backgroundColor: [UIControl.State: UIColor]
    let tintColor: UIColor
    var borderConfig: ButtonBorderConfig = .empty
    let isEnabled: Bool
    let contentVerticalAlignment: UIControl.ContentVerticalAlignment
    let contentHorizontalAlignment: UIControl.ContentHorizontalAlignment
    let tapClosure: VoidClosure?
    
    init(title: [UIControl.State : String],
         attributedTitle: [UIControl.State: NSAttributedString]? = nil,
         titleTextColor: [UIControl.State : UIColor],
         titleFont: UIFont,
         image: [UIControl.State : UIImage?] = [:],
         backgroundColor: [UIControl.State : UIColor],
         tintColor: UIColor,
         isEnabled: Bool = true,
         contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center,
         contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
         tapClosure: VoidClosure? ) {
        self.title = title
        self.attributedTitle = attributedTitle
        self.titleTextColor = titleTextColor
        self.titleFont = titleFont
        self.image = image
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.isEnabled = isEnabled
        self.contentVerticalAlignment = contentVerticalAlignment
        self.contentHorizontalAlignment = contentHorizontalAlignment
        self.tapClosure = tapClosure
    }
    
    static var defaultConfig: ButtonConfig {
        .init(title: [.normal : ""],
              titleTextColor: [.normal: .black],
              titleFont: .systemFont(ofSize: 12),
              image: [:],
              backgroundColor: [.normal: .white],
              tintColor: .white,
              tapClosure: nil)
    }
}

extension ButtonConfig: Hashable, Equatable {
    static func == (lhs: ButtonConfig, rhs: ButtonConfig) -> Bool {
        lhs.title[.normal] == rhs.title[.normal] &&
        lhs.titleFont == rhs.titleFont &&
        lhs.tintColor == rhs.tintColor &&
        lhs.borderConfig == rhs.borderConfig &&
        lhs.isEnabled == rhs.isEnabled
    }
    
    func hash(into hasher: inout Hasher) {
        title.forEach({ $0.value.hash(into: &hasher) })
        titleTextColor.forEach({ $0.value.hash(into: &hasher) })
        titleFont.hash(into: &hasher)
        backgroundColor.forEach({ $0.value.hash(into: &hasher) })
        tintColor.hash(into: &hasher)
        borderConfig.hash(into: &hasher)
        isEnabled.hash(into: &hasher)
    }
}

struct ButtonBorderConfig: Equatable, Hashable {
    let borderColor: [UIControl.State: UIColor]
    let borderThickness: CGFloat
    let cornerRadiusHeightProportion: CGFloat

    init(borderColor: [UIControl.State: UIColor],
         borderThickness: CGFloat = 2.0,
         cornerRadiusHeightProportion: CGFloat = 0.5) {
        self.borderColor = borderColor
        self.borderThickness = borderThickness
        self.cornerRadiusHeightProportion = cornerRadiusHeightProportion
    }

    static var empty: ButtonBorderConfig {
        .init(borderColor: [.normal: .clear],
              borderThickness: 0)
    }

    func hash(into hasher: inout Hasher) {
        borderColor.hash(into: &hasher)
        borderThickness.hash(into: &hasher)
    }
}
