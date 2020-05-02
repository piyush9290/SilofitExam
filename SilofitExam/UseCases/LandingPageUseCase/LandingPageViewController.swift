//
//  LandingPageViewController.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

struct LandingPageViewConfig {
    let theme: Theme
    let joinButtonConfig: ButtonConfig
    let signInButtonConfig: ButtonConfig
}

class LandingPageViewController: UIViewController {
    let joinButton: BorderedDefaultRoundedButton
    let signInButton: DefaultRoundedButton = DefaultRoundedButton(frame: .zero)
    
    private let config: LandingPageViewConfig
    
    init(config: LandingPageViewConfig) {
        self.config = config
        joinButton = BorderedDefaultRoundedButton(frame: .zero)
        joinButton.lineThickness = 1.0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = config.theme.colorForType(.light)
        setUpUI()
        updateUI(withConfig: config)
    }
    
    private func setUpUI() {
        view.addSubview(joinButton)
        view.addSubview(signInButton)
        
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        joinButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        joinButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        joinButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        joinButton.borderColor = config.theme.colorForType(.main)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.leftAnchor.constraint(equalTo: joinButton.leftAnchor).isActive = true
        signInButton.rightAnchor.constraint(equalTo: joinButton.rightAnchor).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: joinButton.topAnchor, constant: -16).isActive = true
        signInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    private func updateUI(withConfig pageConfig: LandingPageViewConfig) {
        joinButton.accept(config: pageConfig.joinButtonConfig)
        signInButton.accept(config: pageConfig.signInButtonConfig)
    }
}
