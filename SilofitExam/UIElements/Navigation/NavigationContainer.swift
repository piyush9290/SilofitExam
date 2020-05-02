//
//  NavigationContainer.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

class NavigationContainer: UIViewController {
    let navigationMenuBar: BasicNavigationBar
    let containerView: UIView
    
    init(navigationConfig: NavigationConfig, containerView: UIView) {
        navigationMenuBar = BasicNavigationBar(config: navigationConfig)
        self.containerView = containerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.view.backgroundColor = .white
    }
    
    private func setUpUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(navigationMenuBar)
        stackView.addArrangedSubview(containerView)
        
        navigationMenuBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.snapSubview(stackView)
    }
}
