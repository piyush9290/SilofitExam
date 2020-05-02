//
//  BlockButton.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-27.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

class BlockButton: UIButton {
    var tapClosure: VoidClosure?
    var colors: [UInt: UIColor] = [:]
    var borderColors: [UInt: UIColor] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDidTapClosure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDidTapClosure()
    }
    
    private func setDidTapClosure() {
        self.addTarget(self, action: #selector(proccessTouchUpInside), for: .touchUpInside)
    }
    
    @objc private func proccessTouchUpInside() {
        tapClosure?()
    }
}

extension BlockButton {
    func setBackgroundColor(_ color: UIColor, for state: UIButton.State) {
        colors[state.rawValue] = color
    }

    func setBorderColor(_ color: UIColor, for state: UIButton.State) {
        borderColors[state.rawValue] = color
    }

    override open var isEnabled: Bool {
        didSet {
            changeBackgroundColor(for: isEnabled ? .normal : .disabled)
            changeBorderColor(for: isEnabled ? .normal : .disabled)
        }
    }
    override open var isSelected: Bool {
        didSet {
            changeBackgroundColor(for: isSelected ? .selected : .normal)
            changeBorderColor(for: isSelected ? .selected : .normal)
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            changeBackgroundColor(for: isHighlighted ? .highlighted : .normal)
            changeBorderColor(for: isHighlighted ? .highlighted : .normal)
        }
    }

    private func changeBackgroundColor(for state: UIButton.State) {
        guard let color = colors[state.rawValue] else { return }
        backgroundColor = color
    }

    private func changeBorderColor(for state: UIButton.State) {
        guard let color = borderColors[state.rawValue] else { return }
        layer.borderColor = color.cgColor
    }
}

extension BlockButton {
    func accept(config: ButtonConfig) {
        config.title.forEach({ self.setTitle($0.value, for: $0.key) })
        config.attributedTitle?.forEach({ self.setAttributedTitle($0.value, for: $0.key) })
        config.titleTextColor.forEach({ self.setTitleColor($0.value, for: $0.key) })
        titleLabel?.font = config.titleFont
        config.image.forEach({ self.setImage($0.value, for: $0.key) })
        imageView?.contentMode = .scaleAspectFit
        config.backgroundColor.forEach({ self.setBackgroundColor($0.value, for: $0.key) })
        tintColor = config.tintColor
        config.borderConfig.borderColor.forEach({ self.setBorderColor($0.value, for: $0.key) })
        isEnabled = config.isEnabled
        contentHorizontalAlignment = config.contentHorizontalAlignment
        contentVerticalAlignment = config.contentVerticalAlignment
        tapClosure = config.tapClosure
    }
}
