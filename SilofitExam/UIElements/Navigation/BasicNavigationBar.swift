//
//  BasicNavigationBar.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct NavigationConfig {
    let leftButtonConfig: ButtonConfig
    let rightButtonConfig: ButtonConfig
    let backgroundColor: UIColor
}

class BasicNavigationBar: UIView {
    let leftButton: BlockButton = BlockButton(frame: .zero)
    let rightButton: BlockButton = BlockButton(frame: .zero)
    
    init(config: NavigationConfig) {
        super.init(frame: .zero)
        setUpUI()
        acceptConfig(navConfig: config)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(leftButton)
        addSubview(rightButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leftButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        leftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        leftButton.rightAnchor.constraint(greaterThanOrEqualTo: rightButton.leftAnchor).isActive = true
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        rightButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
    }
    
    private func acceptConfig(navConfig: NavigationConfig) {
        leftButton.accept(config: navConfig.leftButtonConfig)
        rightButton.accept(config: navConfig.rightButtonConfig)
        self.backgroundColor = navConfig.backgroundColor
    }
}
